import * as Koa from 'koa'
import * as Router from 'koa-router'
import * as bodyparser from 'koa-bodyparser'

require('dotenv-flow').config()
const PORT : string | undefined = process.env.PORT

const app = new Koa()
const router = new Router()

const data = ['lorem', 'ipsum', 'dolor', 'sit', 'amet']

app.use(bodyparser())
router.get('/', async (ctx, next) => {
  const phrase : unknown = ctx.request.query.phrase;
  if (typeof phrase === 'string') {
    ctx.response.body = data.filter(element => element.includes(phrase))
  }
  else {
    ctx.response.body = 'Please provide "phrase" argument in query string'
  }
  await next();
})

console.log(PORT)
if (typeof PORT === 'undefined') {
  throw new Error('Port is undefined') 
}


app
  .use(router.routes())
  .use(router.allowedMethods())
  .listen(PORT, () => {console.log(`Started on localhost:${PORT}`)})