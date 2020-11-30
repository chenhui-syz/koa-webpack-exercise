// const koa = require('koa')
// const path = require('path')
// const helmet = require('koa-helmet')
// const statics = require('koa-static')
// const router = require('./routes/routes')
// 上面的五行是es5的写法，下面的import是es6的写法
import koa from 'koa'
import path from 'path'
import helmet from 'koa-helmet'
import statics from 'koa-static'
import router from './routes/routes'

import koaBody from 'koa-body'
import jsonutil from 'koa-json'
import cors from '@koa/cors'
import compose from 'koa-compose'

const app = new koa()

// app.use(.....)
// app.use(helmet())
// app.use(statics(path.join(__dirname, '../public')))
// app.use(router())
// 把所有的中间件使用compose整合到一起
const middleware = compose([
    koaBody(),
    statics(path.join(__dirname, '../public')),
    cors(),
    jsonutil({
        pretty: false,
        param: 'pretty'
    }),
    helmet()
])
app.use(middleware)
app.use(router())

app.listen(3000, () => {
    console.log('koa is running in 3000')
})