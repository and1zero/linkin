var path = require("path"),
    StatsPlugin = require("stats-webpack-plugin");

var devServerPort = process.env.WEBPACK_DEV_SERVER_PORT,
    devServerHost = process.env.WEBPACK_DEV_SERVER_HOST,
    publicPath = process.env.WEBPACK_PUBLIC_PATH;

var config = {
  entry: path.join(__dirname, "apps/web/assets/javascripts/application.js"),

  output: {
    path: path.join(__dirname, "public"),
    filename: "[name]-[chunkhash].js"
  },

  resolve: {
    modules: [__dirname, 'node_modules']
  },

  plugins: [
    new StatsPlugin("webpack_manifest.json")
  ],

  module: {
    rules: [{
      test: /\.scss$/,
      loaders: ['style-loader', 'css-loader', 'sass-loader']
    }]
  }
};

if (process.env.INBUILT_WEBPACK_DEV_SERVER) {
  config.devServer = {
    port: devServerPort,
    headers: { "Access-Control-Allow-Origin": "*" }
  };
  config.output.publicPath = "//" + devServerHost + ":" + devServerPort + "/";
}

module.exports = config;
