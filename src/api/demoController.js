module.exports = function (ctx) {
    ctx.body = {
        "message": "hello from demoController!!!!!"
    }
}

// class DemoController {
//     constructor() {}
//     async demo(ctx) {
//         ctx.body = {
//             'msg': 'body message'
//         }
//     }
// }
// export default new DemoController()