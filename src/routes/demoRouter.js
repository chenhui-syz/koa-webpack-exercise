const Router = require('koa-router')
const b = require('../api/demoController')
const router = new Router()
router.get('/b', b)
module.exports = router

// import Router from 'koa-router'
// import demoController from '../api/demoController'

// const router = new Router()

// router.get('/demo', demoController.demo)

// export default router