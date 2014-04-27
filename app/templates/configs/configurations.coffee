path = require('path')
extend = require('extend')


getEnvironemnt = () ->
	switch process.env.NODE_ENV
		when 'production' then 'production'
		when 'test' then 'test'
		else 'development'


getConfigs = (environmentConfig)->
	appRootPath = path.join(__dirname, '..')
	modulePath = path.join(appRootPath, 'app/modules')
	appViewPath = path.join(appRootPath, 'app/views')
	stylesPath = path.join(appRootPath, 'public/css/')
	staticPath = path.join(appRootPath, 'public')
	tempPath = path.join(appRootPath, 'tmp')
	config = {
		stylesPath: stylesPath
		staticPath: staticPath
		modulePath: modulePath
		appViewPath : appViewPath
		tempPath: tempPath
		cookieSecret: 'notify@25041361@sec'
		rootPath: appRootPath
		logger:
			info: (message) ->
				console.log message

			debug: (message)->
				console.log(message)

			error: (message, code) ->
				console.error(message)
				console.error(code)
		constructCallback :(req, res, onSuccess, onError)->
			return (data, hasError, code)->
				response =
					code : 0
				if hasError
					response.message = data
					response.code = code if code
					if onError
						onError response
						return
				else
					response.code = 1
					response.data = data
					if onSuccess
						onSuccess response
						return

				res.send(response)

	}
	extend(true, environmentConfig, config)



module.exports = () ->
	if !configInstance
		environmentConfig = require('./environments/' + getEnvironemnt())
		configInstance = getConfigs environmentConfig;
	configInstance
