import { execFile } from 'child_process';
import * as os from 'os';
import * as path from 'path';
import { promisify } from 'util';

import * as vscode from 'vscode';

const execFileAsync = promisify(execFile);

const INSTALL_HINT =
  'Install the CLI from the monorepo root with:\n' +
  '  dart install ./tools/brick_generator\n' +
  'Then ensure the Dart install bin directory is on PATH, or set brickGenerator.cliPath.';

/** Resolves an available brick_generator CLI executable and verifies it runs. */
export async function resolveBrickGeneratorCli(): Promise<string> {
  const configured = vscode.workspace
    .getConfiguration('brickGenerator')
    .get<string>('cliPath')
    ?.trim();

  for (const candidate of getCliCandidates(configured)) {
    if (await isBrickGeneratorCliAvailable(candidate)) {
      return candidate;
    }
  }

  throw new Error(`The brick_generator CLI was not found.\n${INSTALL_HINT}`);
}

function getCliCandidates(configured?: string): string[] {
  const candidates = [
    configured,
    'brick_generator',
    getDefaultDartInstallExecutable(),
    path.join(os.homedir(), '.pub-cache/bin/brick_generator'),
  ].filter((value): value is string => Boolean(value?.trim()));

  return [...new Set(candidates)];
}

function getDefaultDartInstallExecutable(): string | undefined {
  if (process.platform === 'win32') {
    const localAppData = process.env.LOCALAPPDATA?.trim();
    if (!localAppData) {
      return undefined;
    }
    return path.join(
      localAppData,
      'Dart',
      'install',
      'bin',
      'brick_generator.exe',
    );
  }

  if (process.platform === 'darwin') {
    return path.join(
      os.homedir(),
      'Library/Application Support/Dart/install/bin/brick_generator',
    );
  }

  return path.join(
    os.homedir(),
    '.local/share/Dart/install/bin/brick_generator',
  );
}

async function isBrickGeneratorCliAvailable(command: string): Promise<boolean> {
  try {
    await execFileAsync(command, ['preview'], { timeout: 10_000 });
    return true;
  } catch (error) {
    if (isCommandNotFound(error)) {
      return false;
    }

    const stderr = readExecStderr(error);
    if (
      stderr.includes('Missing required --file') ||
      stderr.includes('Missing value for --file')
    ) {
      return true;
    }

    return !isCommandNotFound(error);
  }
}

function isCommandNotFound(error: unknown): boolean {
  return (
    typeof error === 'object' &&
    error !== null &&
    'code' in error &&
    (error as NodeJS.ErrnoException).code === 'ENOENT'
  );
}

function readExecStderr(error: unknown): string {
  if (typeof error !== 'object' || error === null || !('stderr' in error)) {
    return '';
  }
  const stderr = (error as { stderr?: string | Buffer }).stderr;
  if (typeof stderr === 'string') {
    return stderr;
  }
  return stderr?.toString() ?? '';
}
