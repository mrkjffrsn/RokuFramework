
function TestSuite__BaseController()

  this = BaseTestSuite()

  this.name = "BaseController"

  ' Set up and Tear down methods'
  this.SetUp = TestSuite__BaseController__SetUp
  this.TearDown = TestSuite__BaseController__TearDown

  this.addTest("Request Query Key Checks", TestCase__BaseController_RequestQueryKeyChecks)
  this.addTest("Request Query URL Check", TestCase__BaseController_RequestQueryUrlCheck)
  this.addTest("Request Query Method Check", TestCase__BaseController_RequestQueryMethodCheck)
  this.addTest("Request Query ModelType Check", TestCase__BaseController_RequestQueryModelTypeCheck)

  return this
end function


function TestSuite__BaseController__SetUp()

  ' create mock request obj
  mockRequest = {
    url: "https://www.google.com/json",
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    },
    callback: function( data, params )

    end function,
    callbackParams: { page: "HomePage" }
  }

  m.request = createRequestQuery( mockRequest )
end function

function TestSuite__BaseController__TearDown()
  m.request = invalid
end function


'********** TEST CASES ***********'

function TestCase__BaseController_RequestQueryKeyChecks()

  keys = [ "url", "headers", "data", "method", "id", "modelType" ]
  return m.AssertAAHasKeys( m.request, keys )
end function

function TestCase__BaseController_RequestQueryUrlCheck()
  return m.AssertNotInvalid( m.request.url )
end function

function TestCase__BaseController_RequestQueryMethodCheck()
  return m.AssertNotInvalid( m.request.method )
end function

function TestCase__BaseController_RequestQueryModelTypeCheck()
  return m.AssertNotInvalid( m.request.modelType )
end function
