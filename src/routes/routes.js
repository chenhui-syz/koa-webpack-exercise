// import combineRoutes from('koa-combine-routers')
const combineRoutes = require('koa-combine-routers')
// import demoRouter from('./demoRouter')
const demoRouter = require('./demoRouter')
// export default combineRoutes(demoRouter)
module.exports = combineRoutes(
    demoRouter
)