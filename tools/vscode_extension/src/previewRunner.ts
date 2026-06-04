import { execFile } from 'child_process';
import * as path from 'path';
import { promisify } from 'util';

import type { BrickScopeInfo } from './brickScope';
import { formatVarsForCli } from './brickVariables';

const execFileAsync = promisify(execFile);

export async function runPreviewCommand(options: {
  scope: BrickScopeInfo;
  filePath: string;
  vars: Record<string, string | boolean | number>;
}): Promise<string> {
  const mainDart = path.join(
    options.scope.monorepoRoot,
    'tools/brick_generator/lib/main.dart',
  );
  const args = [
    'run',
    mainDart,
    'preview',
    '--file',
    options.filePath,
    '--brick',
    options.scope.scopeName,
    '--root',
    options.scope.monorepoRoot,
  ];

  const varsArg = formatVarsForCli(options.vars);
  if (varsArg.length > 0) {
    args.push('--vars', varsArg);
  }

  try {
    const { stdout } = await execFileAsync('dart', args, {
      cwd: options.scope.monorepoRoot,
      maxBuffer: 16 * 1024 * 1024,
    });
    return stdout;
  } catch (error) {
    throw toPreviewCommandError(error);
  }
}

function toPreviewCommandError(error: unknown): Error {
  if (!(error instanceof Error) || !('stderr' in error)) {
    return error instanceof Error ? error : new Error(String(error));
  }

  const execError = error as Error & { stderr?: string | Buffer; code?: number };
  const stderr =
    typeof execError.stderr === 'string'
      ? execError.stderr
      : execError.stderr?.toString() ?? '';
  const message = stderr.trim() || execError.message;
  return new Error(message);
}
