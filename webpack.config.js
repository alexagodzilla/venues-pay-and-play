const path = require("path");
const webpack = require("webpack");

module.exports = {
	mode: "production",
	devtool: "source-map",
	entry: {
		application: "./app/javascript/application.js",
	},
	output: {
		filename: "[name].js",
		sourceMapFilename: "[file].map",
		path: path.resolve(__dirname, "app/assets/builds"),
	},
	plugins: [
		new webpack.optimize.LimitChunkCountPlugin({
			maxChunks: 1,
		}),
	],
	resolve: {
		extensions: [".js", ".jsx", ".json"],
		alias: {
			"@mapbox/mapbox-gl-geocoder$":
				"@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.min.js",
		},
	},
};
