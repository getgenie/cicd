const express = require('express')
const app = express()
const port = 3000

const build = '1'

app.get('/pool', (req, res) => { // for health check
    res.send(`OK`)
})

app.get('/', (req, res) => {
    res.send(`Hello World! build: ${build}`)
})

const server = app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})

function closeGracefully(signal) {
    server.close(() => {
        console.log(`'HTTP server closed'`)
    })
}

process.on('SIGTERM', closeGracefully)