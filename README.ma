从零开始手动配置一个可用于实际生产需求的koa+webpack项目
使用方法：
下载后npm i下载依赖
npm run webpack启用webpack

所有的路由都写在index.js中，当路由功能变多的时候肯定是不合理的
- 按照功能模块进行区分
- 路由压缩中间件 ：koa-combine-routers
使用一个路由中间件，就要引入和use使用一次，当中间件变多的时候，indexjs依旧会变得很冗长
- 静态资源统一处理中间件 koa-static
npm install koa-static -S

npm -init- y初始化一个新项目
npm install koa koa-router koa-body @koa/cors koa-json -S
npm install koa-combine-routers -S

api文件夹   放路由的一些具体业务以及实现
routes 放路由的请求路径 routesjs  在这个文件里做combine router的操作

header安全处理
npm install koa-helmet -S

nodemon配置koa热加载
npm i -D nodemon

配置webpack，让项目支持es6语法
npm i -D webpack webpack-cli
接下来安装一些用到的webpack插件
npm i -D clean-webpack-plugin
清理dist文件夹
 webpack-node-externals
快速处理node_modules文件夹下的用不到的模块
@babel/core @babel/node @babel/preset-env babel-loader cross-env(设置环境变量) 
上面的插件都安装完成了之后，接下来书写webpack.config.js（后面可以把开发/生产的webpack配置分文件进行保存）

当indexjs使用es6语法之后，这时候启动项目就不能使用 npx src/index.js 这个指令了，而应该用   npx babel-node src/index.js  ，如果想要热更新  ，则要用 npx nodemon --exec babel-node src/index.js，在pkgjson的scripts添加属性
```
"start:es6": "nodemon --exec babel-node src/index.js"
```
调试方法之一：在webpack.config.js打印配置信息
```
console.log(webpackconfig)
```
调试方法之二：打印webpack配置加载的过程
```
npx node --inspect-brk ./node_modules/.bin/webpack --inline -progress
```
执行了这个命令之后，命令行工具会出现提示：debugger listening on xxxxx，此时进入chrome的inspect页面：Remote Target，打开这个页面在项目文件自己想要调试的地方加入debugger端点，再次执行指令，可以很清楚的看到执行过程的参数

上面配置的项目还有几个点需要优化才能满足基本的生产需求
1.没有引用koa-body，对于请求body的处理会很麻烦
2.webpack.config.js只是配置了开发过程中的webpack，并没有对打包进行优化，pkgjson也没有配置打包命令

npm-check-updates
 作用：检查npm的依赖包
全局安装
npm install -g npm-check-updates
安装了之后就可以使用ncu指令
输入ncu     自动检查有没有包有更新   ncu -u   去更新监测出来可以进行更新的版本
rm -rf node_modules
npm i
删除依赖包并重新安装

每一个中间件都需要import和use非常的麻烦，推荐一个依赖包可以帮助我们整合依赖包
koa-compose
npm i koa-compose

接下来优化webpack
通常来说  webpack的配置会分开发模式和生产模式
新建一个config文件夹，文件夹下新建一个webpack.config.base.js  ,这个文件夹下放置的代码，是通用的。另外还有prod和dev文件
在base文件中，通过DefinePlugin去动态的设置NODE_ENV 
```
new webpack.DefinePlugin({
    'process.env': {
        NODE_ENV: (process.env.NODE_ENV === 'production' || process.env.NODE_ENV === 'prod') ? "'production" : "'development"
    }
})
```
在正式打包的时候，需要把多个配置文件进行合并，这里再推荐一个npm包
npm i webpack-merge -D

dev生产模式的配置中需要对代码进行压缩，这里推荐一个插件
（曾经是uglify）
npm install terser-webpack-plugin --save-dev

接下来对chunk进行优化（通用代码，避免重复的引用依赖）
splitChunksPlugin

接下来增加pkg里的scripts

在inexjs定义isDevMode，如果是false，则压缩中间件
npm i koa-compress -S