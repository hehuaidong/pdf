const Koa = require('koa')
const app = new Koa()
const server = require('http').createServer(app.callback());
const bodyparser = require('koa-bodyparser')

const route = require('./route');

app.use(bodyparser({
    enableTypes:['json', 'form', 'text']
  }))

app.use(async (ctx, next) => {
	ctx.set('Content-Type','application/x-www-form-urlencoded')
	const start = new Date()
	await next()
	const ms = new Date() - start
	console.log(`${ctx.method} ${ctx.url} - ${ms}ms`)
})

app.use(route.routes(), route.allowedMethods());


server.listen(3000, () => {
    console.log(`监听地址: http://127.0.0.1:3000`);
})
