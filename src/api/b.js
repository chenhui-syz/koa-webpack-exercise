// function b(ctx) {
//     ctx.body = {
//         "message": "hello from a"
//     }
// }

// module.exports = {
//     b
// }

module.exports = function (ctx) {
    ctx.body = {
        "message": "hello from b"
    }
}