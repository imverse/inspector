// rollup.config.js
import resolve from 'rollup-plugin-node-resolve';
import commonJS from 'rollup-plugin-commonjs'

export default {
  input: 'index.js',
  output: {
    file: 'dist/index.js',
    format: 'iife'
  },
  plugins: [
    resolve(),
    commonJS({
      include: 'node_modules/**'
    })
  ]
};
