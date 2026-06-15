import * as fs from 'fs';
import * as path from 'path';

const CLAY_YAML = 'clay.yaml';
const REFERENCE_DIR = 'reference';
const BRICK_YAML_RELATIVE = path.join('brick', 'brick.yaml');

export interface BrickScopeInfo {
  scopeName: string;
  scopeDir: string;
  referenceDir: string;
  monorepoRoot: string;
  brickYamlPath: string;
}

/** Finds the brick scope for a reference file by walking up to `clay.yaml`. */
export function findBrickScopeForFile(filePath: string): BrickScopeInfo | undefined {
  const resolvedFile = path.resolve(filePath);
  let dir = path.dirname(resolvedFile);

  while (true) {
    const clayConfigPath = path.join(dir, CLAY_YAML);
    if (fs.existsSync(clayConfigPath)) {
      const referenceDir = path.join(dir, REFERENCE_DIR);
      if (!isPathWithinDirectory(resolvedFile, referenceDir)) {
        return undefined;
      }

      const monorepoRoot = findMonorepoRoot(dir);
      if (!monorepoRoot) {
        return undefined;
      }

      const brickYamlPath = path.join(dir, BRICK_YAML_RELATIVE);
      if (!fs.existsSync(brickYamlPath)) {
        return undefined;
      }

      return {
        scopeName: path.basename(dir),
        scopeDir: dir,
        referenceDir,
        monorepoRoot,
        brickYamlPath,
      };
    }

    const parent = path.dirname(dir);
    if (parent === dir) {
      return undefined;
    }
    dir = parent;
  }
}

function isPathWithinDirectory(targetPath: string, directoryPath: string): boolean {
  const relative = path.relative(directoryPath, targetPath);
  return relative !== '' && !relative.startsWith('..') && !path.isAbsolute(relative);
}

function findMonorepoRoot(fromDir: string): string | undefined {
  let dir = fromDir;
  while (true) {
    if (
      fs.existsSync(path.join(dir, 'bricks')) &&
      fs.existsSync(path.join(dir, 'pubspec.yaml'))
    ) {
      return dir;
    }

    const parent = path.dirname(dir);
    if (parent === dir) {
      return undefined;
    }
    dir = parent;
  }
}
