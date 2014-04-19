module.exports = {
	create: function (generator, dirName) {

		// Checking if any contents in the folder
		var files = fs.readdirSync(__dirname);
		var fileCount = files.length;

		if (fileCount > 0) {
			// There are already files in the directory so create a folder with name given by the user
			generator.mkdir(dirName);
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

			'config/environments',

			//Level Three
			'app/views/controls',
			'app/views/includes',
			'app/views/templates',
			'app/views/layouts'
		];

		for (var i = 0; i < paths.length; i++) {
			generator.mkdir(dirName + '/' + paths[i]);
		}

		//Templates
		generator.template('_package.json', dirName + '/package.json');
		generator.template('_bower.json', dirName + '/bower.json');

		var configPath = dirName + '/config';
		generator.template('environment/_development.json', configPath + '/package.json');
		generator.template('environment/_production.json', configPath + '/bower.json');
		generator.template('environment/_test.json', configPath + '/package.json');


	}
};