// rollup.config.js
import commonJS from 'rollup-plugin-commonjs'
import resolve from 'rollup-plugin-node-resolve';

export default {
  input: 'index.js',
  output: {
    file: 'dist/index.js',
    format: 'iife'
  },
  plugins: [resolve(), commonJS({
    include: 'node_modules/**'
  })]
};
