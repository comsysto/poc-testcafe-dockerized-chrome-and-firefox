import { Selector } from 'testcafe'

const baseUrl = <string>process.env.BASE_URL

console.log('BASEURL: ', baseUrl)

fixture('Smoke-Test').page(`${baseUrl}/`)
//  .beforeEach(async (t: TestController) => {
//    await t.maximizeWindow()
//  })

test('Page should display hello', async (t: TestController) => {
  await t.expect(Selector('div').withText('Hello').exists).ok('hello should be shown')
})
