var express = require('express')
var app = express()

app.get('/', function(req, res) {
  res.send(`<!doctype html>
  <html lang="en">
  <head>
    <meta charset="utf-8">
    <title>App</title>
  </head>

  <body>
    <div>Hello</div>
  </body>
  </html>`)
})

app.listen(4000, function() {
  console.log('Example app listening on port 4000!')
})
