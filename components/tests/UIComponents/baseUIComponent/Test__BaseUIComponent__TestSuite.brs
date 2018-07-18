
function TestSuite__BaseUIComponent()

  this = BaseTestSuite()

  this.name = "BaseUIComponent"

  ' Set up and Tear down methods'
  this.SetUp = TestSuite__BaseUIComponent__SetUp
  this.TearDown = TestSuite__BaseUIComponent__TearDown

  ' Test for focus map'
  this.addTest("Focus Map Test", TestCase__BaseUIComponent_CreateFocusMap )

  return this
end function


function TestSuite__BaseUIComponent__SetUp()

  m.scene = GetScene()

  m.container = CreateObject("roSGNode", "Group")
  m.container.id = "testContainer"
  for i=0 to 2
    rect = CreateObject("roSGNode", "Rectangle")
    rect.translation = [10*i, 0]
    rect.width = 5
    rect.height = 5
    rect.id = "testRect" + i.toStr()
    rect.focusable = true
    m.container.appendChild(rect)
  end for
  m.scene.appendChild(m.container)
  m.focusMap = {
    "testRect0":{left:invalid, right:"testRect1", up:invalid, down:invalid},
    "testRect1":{left:"testRect0", right:"testRect2", up:invalid, down:invalid},
    "testRect2":{left:"testRect1", right:invalid, up:invalid, down:invalid},
  }

end function

function TestSuite__BaseUIComponent__TearDown()
  m.scene.removeChild(m.container)
  m.scene = invalid
  m.focusMap = invalid
  m.container = invalid
end function

'********** TEST CASES ***********'

function TestCase__BaseUIComponent_CreateFocusMap()

  focusMap = createFocusMap(m.container.getChildren(3,0))
  return m.assertEqual(focusMap, m.focusMap)

end function
