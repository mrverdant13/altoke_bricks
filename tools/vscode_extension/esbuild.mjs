import * as esbuild from 'esbuild';

const watch = process.argv.includes('--watch');
const production = process.argv.includes('--production');

/** @type {import('esbuild').BuildOptions} */
const buildOptions = {
  entryPoints: ['src/extension.ts'],
  bundle: true,
  outfile: 'out/extension.js',
  external: ['vscode'],
  format: 'cjs',
  platform: 'node',
  sourcemap: !production,
  minify: production,
};

if (watch) {
  const context = await esbuild.context(buildOptions);
  await context.watch();
  console.log('Watching for changes…');
} else {
  await esbuild.build(buildOptions);
}
