/* THIS IS A NODE SERVER THAT EXISTS TO RECIEVE SIGNALS FROM ROKU ON THE CI TO KNOW IF TESTS HAVE SUCCEDED OR NOT.
   NOTE: You do not require to have the server locally to see test results. When running tests locally, you could view the results within the telnet session
 */

const http = require('http');
const url = require('url');

/* NOTE: DO NOT CHANGE THE HOSTNAME.
   It needs to point to the localhost
*/
const hostname = '0.0.0.0';
const port = 3000;

const server = http.createServer((req, res) => {

  var urlParts = url.parse(req.url, true),
      urlParams = urlParts.query,
      urlPathname = urlParts.pathname,
      body = '',
      reqInfo = {};

  if ( urlPathname == '/rokuTests' ) {

    state = urlParams.state

    if (state == "success") {
      console.log(" All Tests Passed - Success ")
      process.exit(0)
    }
    else {
      console.log(" Some Tests failed - Please run tests locally")
      process.exit(1)
    }
  }

  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Temporary Roku Test Server \n');
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
