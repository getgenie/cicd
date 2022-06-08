const express = require('express')
const app = express()
const port = 3000

const build = '1'

app.get('/', (req, res) => {
  res.send(`Hello World! build: ${build}`)
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})