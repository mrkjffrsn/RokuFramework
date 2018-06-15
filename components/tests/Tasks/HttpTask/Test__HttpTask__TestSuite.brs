
function TestSuite__HttpTask()

  this = BaseTestSuite()

  this.name = "HttpTask"

  ' Set up and Tear down methods'
  this.SetUp = TestSuite__HttpTask__SetUp
  this.TearDown = TestSuite__HttpTask__TearDown

  this.addTest("Http Task - ConvertToModel()", TestCase__HttpTask_convertToModelTestCase)

  return this

end function


function TestSuite__HttpTask__SetUp()
end function

function TestSuite__HttpTask__TearDown()
end function

'************ TEST CASES ************'

function TestCase__HttpTask_convertToModelTestCase()

  data = { }
  modelType = invalid

  model = convertToModel( data, modelType )
  return m.assertTrue( model.isSubtype("ContentNode") )
end function
