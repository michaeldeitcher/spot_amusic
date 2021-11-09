process.env.NODE_ENV = process.env.NODE_ENV || 'production'
process.env['API_ROOT'] = 'https://nameless-eyrie-18132.herokuapp.com/'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()
