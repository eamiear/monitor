'use strict';
const path = require('path');
const config = require('./config');

const _ = module.exports = {};

_.cssLoader = config.cssModules ?
  'css-loader?-autoprefixer&modules&importLoaders=1&localIdentName=[name]__[local]___[hash:base64:5]' :
  'css-loader?-autoprefixer';

_.outputPath = config.electron ?
  path.join(__dirname, '../dist') :
  path.join(__dirname, '../dist');

_.outputIndexPath = config.electron ?
  path.join(__dirname, '../dist/index.html') :
  path.join(__dirname, '../dist/index.html');

_.target = config.electron ?
  'electron-renderer' :
  'web';
