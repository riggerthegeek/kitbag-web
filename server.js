/**
 * Server
 *
 * Creates a web server for the project
 *
 * @todo convert to coffeescript
 */

'use strict';


/* Node modules */
var http = require('http');


/* Third-party modules */
var express = require('express');
var httpProxy = require('http-proxy');


/* Files */


var App = function (ipAddress, port, apiUrl) {

  var self = this;

  self._app = express();
  self._proxy = httpProxy.createProxyServer();

  self._config = {
    apiUrl: apiUrl || 'https://api.kitbag.io/',
    ipAddress: ipAddress || 'localhost',
    port: port || 4000,
    publicDir: __dirname + '/dist'
  };

  console.log(JSON.stringify(self._config, null, 4));


  /**
   * Init
   *
   * This initializes the application and gets it
   * all ready for running
   *
   * @private
   */
  self._init = function () {

    self._app.use(function (req, res, cb) {
      cb();
    });

    self._app.all('/api/*', function (req, res, cb) {
      /* Remove /api from the URL */
      req.url = req.url.replace(/^\/api/i, '');

      return self._proxy.web(req, res, {
        changeOrigin: true,
        target: self._config.apiUrl
      }, function (err) {
        console.log(err);
        res.status(500)
          .send('Internal server error');
      });
    });

    self._app.use(express.static(self._config.publicDir));

    self._app.all('/*', function (req, res) {
      res.sendFile(self._config.publicDir + '/index.html');
    });

  };


  /**
   * Start
   *
   * Starts up the server
   */
  self.start = function () {

    self._app.listen(self._config.port, self._config.ipAddress, function () {
      console.log('Listening at %s:%s', self._config.ipAddress, self._config.port);
    });

  };


  /* Run the init method */
  self._init();

};


/* Invoke and start */
var app = new App(process.env.OPENSHIFT_NODEJS_IP, process.env.OPENSHIFT_NODEJS_PORT, process.env.KITBAG_API_URL);
app.start();
