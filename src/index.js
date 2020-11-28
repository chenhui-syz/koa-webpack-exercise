// const koa = require('koa')
// const path = require('path')
// const helmet = require('koa-helmet')
// const statics = require('koa-static')
// const router = require('./routes/routes')
// 上面的五行是es5的写法，下面的import是es6的写法
import koa from 'koa'
import path from 'path'
import helmet from 'koa-helmet'
import statics from 'koa-statics'
import router from './routes/routes'

const app = new koa()

app.use(helmet())
app.use(statics(path.join(__dirname, '../public')))
app.use(router())
app.listen(3000, () => {
    console.log('koa is running in 3000')
})