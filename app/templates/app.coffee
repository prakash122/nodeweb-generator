
express = require('express')
http = require('http')
passport = require('passport')

configs = require('./config/configurations')();

#Connect to db and init mongoose models
require('./config/mongoose') configs

require('./config/passport') passport, configs

configs.passport = passport
app = express();
require('./config/express') app, configs, passport;
require('./config/router') app, configs, passport;

app.listen app.get('port'), ()->
	console.log('Express server listening on port ' + app.get('port'));