fs = require('fs');
path = require('path');

module.exports = {
	create: function (generator, dirName) {

		// Checking if any contents in the folder

		var files = fs.readdirSync(__dirname);
		var fileCount = files.length;

		if (fileCount > 0) {
			// There are already files in the directory so create a folder with name given by the user
			generator.mkdir(dirName);
			process.chdir(path.join(process.cwd(), dirName))
		} else {
			dirName = '';
		}

		var paths = [
			//Level One
			'app',
			'config',
			'public',

			//Level two
			'app/models',
			'app/modules',
			'app/views',
			'app/lib',

			'config/environments',

			//Level Three
			'app/views/controls',
			'app/views/includes',
			'app/views/templates',
			'app/views/layouts'
		];

		for (var i = 0; i < paths.length; i++) {
			generator.mkdir( paths[i]);
		}

		//Templates
		generator.template('_package.json',  'package.json');
		generator.template('_bower.json',  'bower.json');


		var configPath =  'config';
		var environmentPath = configPath + '/environments';

		var srcConfigPath = 'configs';
		var srcEnvironmentPath = srcConfigPath + '/environments/';

		// Environment files creation
		generator.template(srcEnvironmentPath + '_development.coffee', environmentPath + '/development.coffee');
		generator.template(srcEnvironmentPath + '_production.coffee', environmentPath + '/production.coffee');
		generator.template(srcEnvironmentPath + '_test.coffee', environmentPath + '/test.coffee');

		//Creating express config
		generator.template('configs/express.coffee', configPath + '/express.coffee');

		//Creating mongoose config
		generator.copy('configs/mongoose.coffee', configPath + '/mongoose.coffee');

		//Creating passport config
		generator.copy('configs/passport.coffee', configPath + '/passport.coffee');
		generator.copy('configs/router.coffee', configPath + '/router.coffee');

		generator.copy('configs/configurations.coffee', configPath + '/configurations.coffee');

		//Copying app.coffee
		generator.copy('app.coffee',  'app.coffee');

		var appPath = 'app';
		//Now the app contents
		generator.copy('app/models/User.coffee', appPath + '/models/User.coffee');


	}
};