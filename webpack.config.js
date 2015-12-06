var path = require('path');
var webpack = require('webpack');

module.exports = {
  entry: './src/app.js',
  output: {
    path: path.join(__dirname, 'dist'),
    filename: 'bundle.js',
    publicPath: '/static/'
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        loaders: ['babel'],
        exclude: /node_modules/,
        include: __dirname
      },
      {
        loaders: ['elm-simple-loader'],
        test: /\.elm$/,
        exclude: /node_modules/,
        include: __dirname
      }
    ]
  }
};