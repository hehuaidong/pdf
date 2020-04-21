const router = require('koa-router')();
router.prefix('/api');
const puppeteer = require('puppeteer');


router.get(`/userInfo`, async (ctx, next) => {
    let ctxBody = ctx.request.body;

    let {guid} = 'admin';

    ctx.body = {
        code: 1000,
        data: {
            user: 'niu',
            age: 10
        },
        msg: 'success',
    }
    
})

router.post('/covertPdf', async(ctx, next) => {

    console.log(ctx.request)

    let {url, name} = ctx.request.body;

    if (!url || !name) {
        ctx.body = {
            code: 1001,
            msg: '请填写完整信息',
            data: ''
        }
    } else {
        await (async () => {
            const browser = await puppeteer.launch();
            const page = await browser.newPage();
            await page.goto(url, {waitUntil: 'networkidle2'});
            await page.pdf({path: `./${name}.pdf`, format: 'A4'});          
            await browser.close();

            
        })();

        ctx.body = {
            code: 1000,
            msg: '转化成功',
            data: 'success'
        }
    }
});

module.exports = router;
