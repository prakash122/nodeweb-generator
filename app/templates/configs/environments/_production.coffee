path = require("path")

module.exports =
	db: <%= dbUrl %>
	port: 3000
	appName: "RTD"
	parse:
		appId: "PARSE_APP_ID"
		masterKey : "PARSE_MASTER_KEY"
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
			auth:
				user: "REGISTERED_EMAIL"
				pass: "PASSWORD"
			host:'SMTP_HOSTNAME'
			port : 587
		from: "ALIAS_EMAIL"


