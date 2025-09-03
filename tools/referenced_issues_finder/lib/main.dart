import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shell/git.dart';

final _issueRegex = RegExp(
  r'github\.com/(?<owner>[A-Za-z0-9_.-]+)/(?<repo>[A-Za-z0-9_.-]+)/issues/(?<issue>\d+)',
);

typedef _Issue = ({String owner, String repo, int issueNumber});

Future<void> main(List<String> args) async {
  StreamController<List<int>>? streamController;
  StreamSubscription<List<int>>? streamSubscription;
  try {
    final issues = <_Issue>{};
    final buf = StringBuffer();
    streamController = StreamController<List<int>>();
    streamSubscription = streamController.stream.listen(
      (event) {
        final record = String.fromCharCodes(event);
        buf.write(record);
      },
    );
    final dir = switch (args.firstOrNull) {
      final String dirPath => Directory(dirPath),
      null => Directory.current,
    };
    await Git.listFiles(
      dir,
      // Intentionally avoiding quotes for the exclusion pattern
      // In the terminal, the command would be:
      // `git ls-files -- . ':!:**/__brick__/**'`
      args: ['-- . :!:**/__brick__/**'],
      stdout: streamController,
    );
    final filePaths = LineSplitter.split(buf.toString());
    await Future.wait([
      for (final filePath in filePaths)
        Future(() async {
          final file = File(filePath);
          final content = await file.readAsString().catchError((error) => '');
          final matches = _issueRegex.allMatches(content);
          for (final match in matches) {
            final owner = match.namedGroup('owner');
            if (owner == null) continue;
            final repo = match.namedGroup('repo');
            if (repo == null) continue;
            final issueNumberString = match.namedGroup('issue');
            if (issueNumberString == null) continue;
            final issueNumber = int.parse(issueNumberString);
            final issue = (owner: owner, repo: repo, issueNumber: issueNumber);
            issues.add(issue);
          }
        }),
    ]);
    stdout.writeln(
      jsonEncode(
        issues.toList(),
        toEncodable: (nonEncodable) {
          if (nonEncodable is _Issue) {
            return {
              'owner': nonEncodable.owner,
              'repo': nonEncodable.repo,
              'number': nonEncodable.issueNumber,
            };
          }
          throw ArgumentError('Cannot encode $nonEncodable');
        },
      ),
    );
  } finally {
    await streamSubscription?.cancel();
    await streamController?.close();
  }
}
