
function TestSuite__UIButton()

  this = BaseTestSuite()

  this.name = "UIButton"

  ' Set up and Tear down methods'
  this.SetUp = TestSuite__UIButton__SetUp
  this.TearDown = TestSuite__UIButton__TearDown

  this.addTest("Button Enabled Test", TestCase__UIButton_DisabledTestCheck )
  this.addTest("Button Focued State Test", TestCase__UIButton_FocusedStateSetTest)
  this.addTest("Button UnFocued State Test", TestCase__UIButton_UnfocusedStateSetTest)
  this.addTest("Button Pressed - Focus State Test", TestCase__UIButton_PressedFocusedStateSetTest)
  this.addTest("Button Pressed - UnFocus State Test", TestCase__UIButton_PressedUnfocusedStateSetTest)

  return this
end function


function TestSuite__UIButton__SetUp()

  ' Give Some Values for the Button here'
  m.button = CreateObject("roSGNode", "UIButton")
  m.button.size = [ 96, 96 ]
  m.button.stateImages = {
    "focused" : "pkg:/images/like-focus-nopress.png",
    "unfocused" : "pkg:/images/like.png",
    "pressed_focused" : "pkg:/images/like-focus-pressed.png",
    "pressed_unfocused" : "pkg:/images/like-nofocus-press.png",
    "disabled" : "pkg:/images/like-nofocus-inactive.png"
  }

  m.constants = GetConstants()

end function

function TestSuite__UIButton__TearDown()
  m.button = invalid
end function

'********** TEST CASES ***********'

function TestCase__UIButton_DisabledTestCheck()

  m.button.enabled = false
  result = m.AssertEqual( m.button.state, m.constants.UI_BUTTON_STATES.DISABLED )

  m.button.enabled = true
  return result
end function

function TestCase__UIButton_FocusedStateSetTest()
  m.button.setFocus( true )
  return m.AssertEqual( m.button.state, m.constants.UI_BUTTON_STATES.FOCUSED )
end function

function TestCase__UIButton_UnfocusedStateSetTest()
  m.button.setFocus( false )
  return m.AssertEqual( m.button.state, m.constants.UI_BUTTON_STATES.UNFOCUSED )
end function

function TestCase__UIButton_PressedFocusedStateSetTest()
  m.button.pressed = true
  m.button.setFocus( true )
  return m.AssertEqual( m.button.state, m.constants.UI_BUTTON_STATES.PRESSED_FOCUSED )
end function

function TestCase__UIButton_PressedUnfocusedStateSetTest()
  m.button.pressed = true
  m.button.setFocus( false )
  return m.AssertEqual( m.button.state, m.constants.UI_BUTTON_STATES.PRESSED_UNFOCUSED )
end function
