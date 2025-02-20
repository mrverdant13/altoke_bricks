import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppLocalizations', () {
    test('should have a localized value for each supported locale', () async {
      final result = await Process.run('flutter', [
        'gen-l10n',
      ], runInShell: true);
      expect(result.exitCode, isZero);
      expect(result.stderr, isEmpty);
      final l10nFile = File('l10n.yaml');
      expect(l10nFile.existsSync(), isTrue);
      final untranslatedMessagesFilePathRegex = RegExp(
        'untranslated-messages-file: (.+)',
      );
      final untranslatedMessagesFilePath = untranslatedMessagesFilePathRegex
          .firstMatch(l10nFile.readAsStringSync())
          ?.group(1);
      expect(
        untranslatedMessagesFilePath,
        isNotNull,
        reason:
            'The "untranslated-messages-file" key '
            'is missing in the "l10n.yaml" file.',
      );
      final untranslatedMessagesFile = File(untranslatedMessagesFilePath!);
      expect(untranslatedMessagesFile.existsSync(), isTrue);
      final untranslatedMessages =
          jsonDecode(untranslatedMessagesFile.readAsStringSync())
              as Map<String, dynamic>;
      expect(
        untranslatedMessages,
        isEmpty,
        reason: [
          'Some messages are not translated.',
          'Check the ${untranslatedMessagesFile.path} file for more details.',
        ].join('\n'),
      );
    });
  });
}
