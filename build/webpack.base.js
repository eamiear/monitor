'use strict';
const path = require('path');
const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const config = require('./config');
const _ = require('./utils');

module.exports = {
  entry: {
    client: './src/app.js'
  },
  output: {
    path: path.resolve(__dirname, '../dist'),
    publicPath: '/',
    filename: 'bundle.js'
  },
  resolve: {
    extensions: ['', '.js', '.vue', '.css', '.json'],
    alias: {
      'vue$': 'vue/dist/vue.js',
       root: path.join(__dirname, '../src'),
      'src': path.resolve(__dirname, '../src'),
      'components': path.join(__dirname, '../src/components'),
      'assets': path.resolve(__dirname, '../src/assets'),
      'views': path.resolve(__dirname, '../src/views'),
      'muse-components': 'muse-ui/src'
    }
  },
  module: {
    //preLoaders: [{
    //  test: /\.vue$/,
    //  loader: 'eslint',
    //  exclude: /node_modules/
    //},
    //  {
    //  test: /\.js$/,
    //  loader: 'eslint',
    //  exclude: /node_modules/
    //}],

    loaders: [
      {
        test: /\.vue$/,
        loaders: ['vue']
      },
      {
        test: /\.js$/,
        loaders: ['babel'],
        exclude: [/node_modules/]
      },
      {
        test: /\.es6$/,
        loaders: ['babel']
      },
      {
        test: /\.(ico|jpg|png|gif|eot|otf|webp|svg|ttf|woff|woff2)(\?.*)?$/,
        loader: 'file',
        query: {
          name: 'static/media/[name].[hash:8].[ext]'
        }
      },
      {
        // edit this for additional asset file types
        test: /\.(png|jpg|gif)$/,
        loader: 'url',
        query: {
          // inline files smaller then 10kb as base64 dataURL
          limit: 10000,
          // fallback to file-loader with this naming scheme
          name: '[name].[ext]?[hash]'
        }
      },
      {
        test: /muse-ui.src.*?js$/,
        loader: 'babel'
      }
    ]
  },
  //babel: config.babel,
  postcss: config.postcss,
  vue: {
    loaders: {
      js: 'babel'
    },
    postcss: config.postcss
  },
  //eslint: {
  //  formatter: require('eslint-friendly-formatter')
  //},
  plugins: [
    //new HtmlWebpackPlugin({
    //  title: config.title,
    //  template: path.join(__dirname, '../index.html'),
    //  filename: _.outputIndexPath
    //})
  ],
  target: _.target
};
