
function TestSuite__HomeController()

  this = BaseTestSuite()

  this.name = "HomeController"

  this.addTest("HomeTest", TestCase__HomeController_SampleTestCase)

  return this

end function


function TestCase__HomeController_SampleTestCase()

  value = true
  return m.assertTrue( value )
end function
