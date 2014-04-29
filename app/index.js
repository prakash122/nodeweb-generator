'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');
var chalk = require('chalk');
var fs = require('fs');
var directoryStructure = require('./directoryStructure');

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

		var prompts = require('./prompts');
		this.prompt(prompts, function (props) {
			this.appName = props.appName;
//			this.dbUrl = props.dbUrl ? "'" + props.dbUrl + "'" : "process.env.MONGOHQ_URL";
			var dbName = props.dbUrl || 'test';
			this.dbUrl = "'mongodb://localhost/" + dbName + "'";
			done();
		}.bind(this));
	},

	app: function () {
		directoryStructure.create(this, this.appName);
	},

	projectfiles: function () {
		this.copy('editorconfig', '.editorconfig');
		this.copy('jshintrc', '.jshintrc');
	}
});

module.exports = NodewebGenerator;