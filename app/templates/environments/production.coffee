path = require("path")
templatePath = path.normalize(__dirname + "/../app/mailer/templates")

module.exports =
	db: process.env.MONGOHQ_URL
	port: 3010
	app:
		name: "RTD"
	notifier:
		service: "postmark"
		APN: false
		email: false # true
		actions: ["comment"]
		tplPath: templatePath
		key: "POSTMARK_KEY"
	parse:
		appId: "SR3nxUAeP618H9SwY5uPjmRBut3eqsh8TG927Dqr"
		masterKey : "iPi843R6VQmSqfKAjaLM2Tk888hzspEuHhFf5kYp"
	facebook:
		clientID: "APP_ID",
		clientSecret: "APP_SECRET"
		callbackURL: "http://localhost:3000/auth/facebook/callback"
	twitter:
		clientID: "CONSUMER_KEY",
		clientSecret: "CONSUMER_SECRET",
		callbackURL: "http://localhost:3000/auth/twitter/callback"

	github:
		clientID: 'APP_ID',
		clientSecret: 'APP_SECRET',
		callbackURL: 'http://localhost:3000/auth/github/callback'

	google:
		clientID: "APP_ID",
		clientSecret: "APP_SECRET",
		callbackURL: "http://localhost:3000/auth/google/callback"

	linkedin:
		clientID: "CONSUMER_KEY",
		clientSecret: "CONSUMER_SECRET",
		callbackURL: "http://localhost:3000/auth/linkedin/callback"
	mailer :
		smtpSettings:
			#service: "Gmail"
			#host : "smtp.google.com"
			#secureConnection : true

			auth:
				user: "prakash@noplug.in"
				pass: "gVdHS1Bj5IqK8_3Cg8AKRQ"
			host:'smtp.mandrillapp.com'
			port : 587
		from: "RTD<support@rtd.io>"


