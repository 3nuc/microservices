"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const Koa = require("koa");
const Router = require("koa-router");
const bodyparser = require("koa-bodyparser");
require('dotenv-flow').config();
const PORT = process.env.PORT;
const app = new Koa();
const router = new Router();
const data = ['lorem', 'ipsum', 'dolor', 'sit', 'amet'];
app.use(bodyparser());
router.get('/', (ctx, next) => __awaiter(void 0, void 0, void 0, function* () {
    const phrase = ctx.request.query.phrase;
    if (typeof phrase === 'string') {
        ctx.response.body = data.filter(element => element.includes(phrase));
    }
    else {
        ctx.response.body = 'Please provide "phrase" argument in query string';
    }
    yield next();
}));
console.log(PORT);
if (typeof PORT === 'undefined') {
    throw new Error('Port is undefined');
}
app
    .use(router.routes())
    .use(router.allowedMethods())
    .listen(PORT, () => { console.log(`Started on localhost:${PORT}`); });
