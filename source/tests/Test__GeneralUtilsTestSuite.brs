
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
  this.addTest("Capitalize Method", TestCase__GeneralUtils_capitalizeTestCase)
  this.addTest("QueryString Symbol Check", TestCase__GeneralUtils_queryStringSymbolTestCase)

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

function TestCase__GeneralUtils_capitalizeTestCase()

  text = "sports and Talk"
  result = CapitalizeString( text )
  return m.assertEqual( result, "Sports And Talk" )
end function

function TestCase__GeneralUtils_queryStringSymbolTestCase()

  url = "https://www.google.com/search?source=hp&ei=wKp1W9XUEeHQjwTShLaoCg&q=hello&oq=Hell&gs_l=psy-ab.3.0.0j0i131k1l4j0l5.2809.3263.0.4495.6.5.0.0.0.0.87.292.4.5.0....0...1c.1.64.psy-ab..1.4.291.0...55.vmdQHLolNwI"
  symbol = getQueryStringSymbol( url )

  return m.assertEqual( symbol, "&" )
end function
