import { Selector } from 'testcafe'

// Test if it is some docker-dns failing thingy
// => use => https://comsysto.github.io/poc-testcafe-dockerized-chrome-and-firefox/

const baseUrl = <string>process.env.BASE_URL

console.log('BASEURL: ', baseUrl)

fixture('Smoke-Test').page(`${baseUrl}/`)
//  .beforeEach(async (t: TestController) => {
//    await t.maximizeWindow()
//  })

test('Page should display hello', async (t: TestController) => {
  await t.expect(Selector('div').withText('Hello').exists).ok('hello should be shown')
})
