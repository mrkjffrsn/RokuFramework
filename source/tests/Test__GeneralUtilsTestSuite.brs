
' Sample Test Suite
function TestSuite__GeneralUtils()

  this = BaseTestSuite()

  this.name = "GeneralUtilsTestSuite"

  ' Set up and Tear down methods'
  this.SetUp = GeneralUtilsTestSuite__SetUp
  this.TearDown = GeneralUtilsTestSuite__TearDown

  ' Adding Test cases'
  this.addTest("isValid() Type Check", TestCase__GeneralUtils_isValidTestCase)
  this.addTest("isString() Type Check", TestCase__GeneralUtils_isStringTestCase)
  this.addTest("isObject() Type Check", TestCase__GeneralUtils_isObjectTestCase)
  this.addTest("isArray() Type Check", TestCase__GeneralUtils_isArrayTestCase)
  this.addTest("isBoolean() Type Check", TestCase__GeneralUtils_isBooleanTestCase)
  this.addTest("isInteger() Type Check", TestCase__GeneralUtils_isIntegerTestCase)

  return this
end function

'*********** HELPERS ****************'
function GeneralUtilsTestSuite__SetUp()
end function

function GeneralUtilsTestSuite__TearDown()
end function

'************ TEST CASES ************'

function TestCase__GeneralUtils_isValidTestCase()
  dummyStr = ""
  return m.assertTrue( isValid(dummyStr) )
end function

function TestCase__GeneralUtils_isStringTestCase()
  str = ""
  return m.assertTrue( isString(str) )
end function

function TestCase__GeneralUtils_isObjectTestCase()
  obj = { }
  return m.assertTrue( isObject(obj) )
end function

function TestCase__GeneralUtils_isArrayTestCase()
  arr = []
  return m.assertTrue( isArray(arr) )
end function

function TestCase__GeneralUtils_isBooleanTestCase()
  value = false
  return m.assertTrue( isBoolean(value) )
end function

function TestCase__GeneralUtils_isIntegerTestCase()
  int = 3
  return m.assertTrue( isInteger(int) )
end function
