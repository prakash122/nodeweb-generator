module.exports = (app, config, passport) ->
	fs = require('fs')
	path = require('path')
	logger = config.logger
	mod_dir = fs.readdirSync(config.modulePath);
	mod_dir.forEach (file) ->
		dirPath = path.join(config.modulePath, file);
		stat = fs.statSync(dirPath);
		if stat and stat.isDirectory()
			routerPath = path.join(dirPath, 'router.coffee');
			if fs.existsSync routerPath
				try
					require(routerPath) app, passport
				catch error
					logger.error error

	# Index template is targeting the admin users.
	# If a user come to know about rtd, he will be able to access all the js files
	# (Once the files are minified I need not worry. But I just felt that they are irrelevant)
	# If security is not a concern and only extra js load is the only problem use a different
	# template.
	app.get('/*', (req, res)->
		#Send the user info if logged in
		templateName = 'index'
		pageInfo = config.getPageInfo req, templateName

		res.render(templateName, {pageInfo:pageInfo, temp:100 });
	);