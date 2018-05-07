
' Sample Test Suite
function TestSuite__Sample()

  this = BaseTestSuite()

  this.name = "SampleTestSuite"

  ' Set up and Tear down methods'

  this.SetUp = SampleTestSuite__SetUp
  this.TearDown = SampleTestSuite__TearDown

  ' Adding Test cases'
  this.addTest("SampleTestCase", TestCase__Sample_SampleTestCase)

  return this
end function

'*********** HELPERS ****************'
function SampleTestSuite__SetUp()

end function

function SampleTestSuite__TearDown()

end function

'************ TEST CASES ************'

function TestCase__Sample_SampleTestCase()

  value = true

  return m.assertTrue( value )
end function
