import type { BrickVariable } from './brickVariables';

type PreviewVarValue = string | boolean | number;

const VALUE_EQUALITY_OPTIONS = [
  'dart_mappable',
  'equatable',
  'freezed',
  'overrides',
  'none',
] as const;

const STATE_MANAGEMENT_OPTIONS = ['bloc', 'riverpod'] as const;
const ROUTER_OPTIONS = ['auto_route', 'go_router'] as const;
const LOCAL_DATABASE_OPTIONS = ['drift', 'hive', 'sembast'] as const;

const ANDROID_IDENTIFIER_PATTERN =
  /^[a-zA-Z][a-zA-Z0-9_]*(?:\.[a-zA-Z][a-zA-Z0-9_]*)+$/;
const APPLE_BUNDLE_IDENTIFIER_PATTERN = /^[a-zA-Z0-9-.]*[a-zA-Z0-9-]$/;

/**
 * Expands user-selected brick variables with hook-derived flags so preview
 * matches what Mason receives during generation.
 */
export function expandPreviewVars(
  variables: BrickVariable[],
  selected: Record<string, PreviewVarValue>,
): Record<string, PreviewVarValue> {
  const expanded: Record<string, PreviewVarValue> = {
    ...selected,
    requirements_met: true,
  };

  for (const variable of variables) {
    const value = selected[variable.name];
    if (value === undefined) {
      continue;
    }

    switch (variable.name) {
      case 'value_equality_approach':
        if (typeof value === 'string') {
          applyExclusiveFlags(expanded, VALUE_EQUALITY_OPTIONS, value);
          expanded.use_code_generation =
            value === 'dart_mappable' || value === 'freezed';
          expanded.use_meta = value === 'dart_mappable' || value === 'overrides';
        }
        break;
      case 'state_management_package':
        if (typeof value === 'string') {
          applyExclusiveFlags(expanded, STATE_MANAGEMENT_OPTIONS, value);
        }
        break;
      case 'router_package':
        if (typeof value === 'string') {
          applyExclusiveFlags(expanded, ROUTER_OPTIONS, value);
        }
        break;
      case 'local_database_alternative':
        if (typeof value === 'string') {
          applyExclusiveFlags(expanded, LOCAL_DATABASE_OPTIONS, value);
        }
        break;
      case 'android_application_identifier':
        applyOptionalPlatformIdentifier(expanded, 'android', value);
        break;
      case 'ios_bundle_identifier':
        applyOptionalPlatformIdentifier(expanded, 'ios', value);
        break;
      case 'macos_bundle_identifier':
        applyOptionalPlatformIdentifier(expanded, 'macos', value);
        break;
      default:
        break;
    }
  }

  return expanded;
}

function applyExclusiveFlags(
  target: Record<string, PreviewVarValue>,
  options: readonly string[],
  selected: string,
): void {
  for (const option of options) {
    target[`use_${option}`] = option === selected;
  }
}

function applyOptionalPlatformIdentifier(
  target: Record<string, PreviewVarValue>,
  platform: 'android' | 'ios' | 'macos',
  rawValue: PreviewVarValue,
): void {
  const identifier = typeof rawValue === 'string' ? rawValue.trim() : '';
  const includeKey = `include_${platform}_platform`;
  if (!identifier) {
    target[includeKey] = false;
    return;
  }

  switch (platform) {
    case 'android':
      if (!ANDROID_IDENTIFIER_PATTERN.test(identifier)) {
        throw new Error(
          `Invalid Android Application Identifier "${identifier}". ` +
            `It must match the pattern: ${ANDROID_IDENTIFIER_PATTERN}`,
        );
      }
      target[includeKey] = true;
      target.android_application_identifier_as_path = identifier
        .split('.')
        .join('/');
      break;
    case 'ios':
    case 'macos':
      if (!APPLE_BUNDLE_IDENTIFIER_PATTERN.test(identifier)) {
        throw new Error(
          `Invalid Apple Bundle Identifier "${identifier}". ` +
            `It must match the pattern: ${APPLE_BUNDLE_IDENTIFIER_PATTERN}`,
        );
      }
      target[includeKey] = true;
      break;
  }
}
