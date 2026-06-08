// cspell:words LOCALAPPDATA

import { execFile } from 'child_process';
import * as os from 'os';
import * as path from 'path';
import { promisify } from 'util';

import * as vscode from 'vscode';

const execFileAsync = promisify(execFile);

const INSTALL_HINT =
  'Install the CLI with:\n' +
  '  dart pub global activate --source git https://github.com/mrverdant13/clay.git --git-path packages/clay_cli\n' +
  'Then ensure the Dart global bin directory is on PATH, or set brickGenerator.cliPath.';

/** Resolves an available clay CLI executable and verifies it runs. */
export async function resolveClayCli(): Promise<string> {
  const configured = vscode.workspace
    .getConfiguration('brickGenerator')
    .get<string>('cliPath')
    ?.trim();

  for (const candidate of getCliCandidates(configured)) {
    if (await isClayCliAvailable(candidate)) {
      return candidate;
    }
  }

  throw new Error(`The clay CLI was not found.\n${INSTALL_HINT}`);
}

function getCliCandidates(configured?: string): string[] {
  const candidates = [
    configured,
    'clay',
    getDefaultDartInstallExecutable(),
    path.join(os.homedir(), '.pub-cache/bin/clay'),
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
      'clay.exe',
    );
  }

  if (process.platform === 'darwin') {
    return path.join(
      os.homedir(),
      'Library/Application Support/Dart/install/bin/clay',
    );
  }

  return path.join(
    os.homedir(),
    '.local/share/Dart/install/bin/clay',
  );
}

async function isClayCliAvailable(command: string): Promise<boolean> {
  try {
    await execFileAsync(command, ['--version'], { timeout: 10_000 });
    return true;
  } catch (error) {
    if (isCommandNotFound(error)) {
      return false;
    }

    const stderr = readExecStderr(error);
    return stderr.includes('0.0.1') || stderr.includes('clay_cli');
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
