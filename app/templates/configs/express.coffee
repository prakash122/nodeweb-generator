path = require('path')

module.exports = (app, config, passport) ->
	express = require('express')
	bodyParser = require('body-parser')
	domain = require('domain')
	mongoStore = require('connect-mongo')(express)

	app.set('views', config.appViewPath)

	# all environments
	app.set('port', process.env.PORT || config.port)
	app.set('view engine', 'jade');
	app.use(express.favicon());
	app.use(express.logger('dev'));

	app.use(bodyParser.json())
	app.use(bodyParser.urlencoded())

	app.use(express.methodOverride());
	app.use(express.cookieParser(config.cookieSecret))
	app.use(passport.initialize());
	app.use(passport.session());
	app.use(express.session({
		secret: '<%= _.slugify(appName)%> is awesome'
		key: 'sid'
		store: new mongoStore({
			url: config.db,
			collection: 'sessions'
		})
		cookie:
			path: '/'
			httpOnly: true
			expires: (1000 * 60 * 60 * 24 * 30 * 6) #180 Days
	}));
	app.passport = passport
	app.use require("less-middleware")(config.staticPath)
	app.use(express.static(config.staticPath));
	app.use('/components', express.static(config.rootPath + '/bower_components'));

	#TODO : Use domain once domain gets stable (http://nodejs.org/api/domain.html)

	app.use(app.router)

	# development error handler
	# will print stacktrace
	if app.get("env") is "development"
		app.use (err, req, res, next) ->

			if req.url.indexOf('/api/') > -1
				res.send
					code : 0
					message: err.message
					error: err
			else
				res.render "error",
					message: err.message
					error: err

	# production error handler
	# no stacktraces leaked to user
	app.use (err, req, res, next) ->
		if req.url.indexOf('/api/') > -1
			res.send
				code : 0
				message: err.message
		else
			res.render "error",
				message: err.message
				error: {}


#merging css can be done and other tasks required in production mode
# change the params of less-middleware to enable compression.
