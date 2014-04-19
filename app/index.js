'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');
var chalk = require('chalk');
var fs = require('fs');

var NodewebGenerator = yeoman.generators.Base.extend({
	init: function () {
		this.pkg = require('../package.json');

		this.on('end', function () {
			if (!this.options['skip-install']) {
				this.installDependencies();
			}
		});
	},

	askFor: function () {
		var done = this.async();

		// have Yeoman greet the user
		this.log(this.yeoman);

		// replace it with a short and sweet description of your generator
		this.log(chalk.magenta('You\'re using the fantastic Nodeweb generator.'));

		var prompts = require('./prompts');
		this.prompt(prompts, function (props) {
			this.appName = props.appName;
			this.dbUrl = props.dbUrl;

			done();
		}.bind(this));
	},

	app: function () {
		var dirName = this.appName;

		// Checking if any contents in the folder
		var files = fs.readdirSync(__dirname);
		console.log(files);
		var fileCount = files.length;
		console.log(__dirname);
		if (fileCount > 0) {
			// There are already files in the directory so create a folder with name given by the user
			this.mkdir(dirName);
		} else {
			dirName = '';
		}

		var paths = [
			//Level One
			'app',
			'config',
			'lib',
			'public',

			//Level two
			'app/models',
			'app/modules',
			'app/views',

			//Level Three
			'app/views/controls',
			'app/views/includes',
			'app/views/templates',
			'app/views/layouts'
		];

		for (var i = 0; i < paths.length; i++) {
			this.mkdir(dirName + '/' + paths[i]);
		}

		//Templates
		this.template('_package.json', dirName + '/package.json');
		this.template('_bower.json', dirName + '/bower.json');
	},

	projectfiles: function () {
		this.copy('editorconfig', '.editorconfig');
		this.copy('jshintrc', '.jshintrc');
	}
});

module.exports = NodewebGenerator;