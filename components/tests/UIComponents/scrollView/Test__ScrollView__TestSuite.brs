
function TestSuite__ScrollView()

  this = BaseTestSuite()

  this.name = "ScrollView"

  ' Set up and Tear down methods'
  this.SetUp = TestSuite__ScrollView__SetUp
  this.TearDown = TestSuite__ScrollView__TearDown

  this.addTest("Scroll Children Count ", TestCase__ScrollView_ChildrenCountCheck )
  this.addTest("Scrollview Mandatory Parameters", TestCase__ScrollView_MandatoryParameters )

  return this
end function


function TestSuite__ScrollView__SetUp()

  ' Give Some Values for the Button here'
  m.scrollView = CreateObject("roSGNode", "scrollView")

  m.components = []

  rect1 = CreateObject("roSGNode", "Rectangle")
  rect1.width = 200
  rect1.height = 200

  rect2 = CreateObject("roSGNode", "Rectangle")
  rect2.width = 200
  rect2.height = 200

  m.components.push( rect1 )
  m.components.push( rect2 )

  m.constants = GetConstants()

end function

function TestSuite__ScrollView__TearDown()
  m.scrollView = invalid
  m.components = []
end function

'********** TEST CASES ***********'

function TestCase__ScrollView_ChildrenCountCheck()

  m.scrollView.children = m.components
  scrollContainer = m.scrollView.findNode("scrollContainer")

  return m.AssertArrayCount( m.components, scrollContainer.getChildCount() )
end function


function TestCase__ScrollView_MandatoryParameters()

  scrollViewFields = m.scrollView.getFields()
  mandatoryFields = [ "viewport", "padding", "children" ]

  return m.AssertAAHasKeys( scrollViewFields, mandatoryFields )

end function
