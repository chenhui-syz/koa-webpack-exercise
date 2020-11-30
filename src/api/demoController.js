// function a(ctx) {
//     ctx.body = {
//         "message": "hello from a"
//     }
// }

// module.exports = {
//     a
// }

module.exports = function (ctx) {
    ctx.body = {
        "message": "hello from a!!!!!"
    }
}

// class DemoController {
//     constructor() {}
//     async demo(ctx) {
//         ctx.body = {
//             msg: 'body message'
//         }
//     }
// }
// export default new DemoController()