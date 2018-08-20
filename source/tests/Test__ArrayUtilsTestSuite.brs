
' Sample Test Suite
function TestSuite__ArrayUtils()

  this = BaseTestSuite()

  this.name = "ArrayUtilsTestSuite"

  ' Set up and Tear down methods'
  this.SetUp = ArrayUtilsTestSuite__SetUp
  this.TearDown = ArrayUtilsTestSuite__TearDown

  ' Adding Test cases'
  this.addTest("ConvertArrayToString TestCase", TestCase__ArrayUtils_convertArrayToString)
  this.addTest("ArrayMap TestCase", TestCase__ArrayUtils_arrayMapTestCase)
  this.addTest("Max() method check", TestCase__ArrayUtils_maxTestCase)
  this.addTest("Array Reduce TestCase", TestCase__ArrayUtils_arrayReduceTestCase)
  this.addTest("Array Filter TestCase", TestCase__ArrayUtils_arrayFilterTestCase)
  this.addTest("Array Slice TestCase", TestCase__ArrayUtils_arraySliceTestCase)
  return this
end function

'*********** HELPERS ****************'
function ArrayUtilsTestSuite__SetUp()
  m.numbers = [ 2, 5, 3 ]
end function

function ArrayUtilsTestSuite__TearDown()
  m.numbers = invalid
end function

function mapTransform( number as Integer )
  return number + 1
end function

function reduceTransform( accumulator as Integer, nextVal as Integer)
  return nextVal + accumulator
end function

function filterTransform( number as Integer )
  if ( ( number MOD 2 ) = 0 ) then return true
  return false
end function

'************ TEST CASES ************'

function TestCase__ArrayUtils_convertArrayToString()
  return m.AssertEqual( convertArrayToString( m.numbers, "*" ), "2*5*3" )
end function

function TestCase__ArrayUtils_maxTestCase()
  return m.AssertEqual( Max( m.numbers ), 5 )
end function

function TestCase__ArrayUtils_arrayMapTestCase()
  mappedArray = arrayMap(m.numbers, mapTransform)
  return m.AssertEqual( mappedArray, [ 3, 6, 4 ] )
end function

function TestCase__ArrayUtils_arrayReduceTestCase()
  result = arrayReduce( m.numbers, 0, reduceTransform )
  return m.AssertEqual( result, 10 )
end function

function TestCase__ArrayUtils_arrayFilterTestCase()
  result = arrayFilter( m.numbers, filterTransform )
  return m.AssertEqual( result, [ 2 ] )
end function

function TestCase__ArrayUtils_arraySliceTestCase()

  sampleArray = [ 1, 2, 3, 4 ]

  slicedArray = arraySlice( sampleArray, 1, 3 )
  return m.AssertEqual( slicedArray, [ 2, 3 ] )
end function
