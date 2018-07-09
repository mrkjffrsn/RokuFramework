
function TestSuite__UIDialog()

  this = BaseTestSuite()

  this.name = "UIDialog"

  ' Set up and Tear down methods'
  this.SetUp = TestSuite__UIDialog__SetUp
  this.TearDown = TestSuite__UIDialog__TearDown

  this.addTest("Open Dialog", TestCase__UIDialog_OpenDialogCheck )
  this.addTest("Close Dialog", TestCase__UIButton_CloseDialogCheck)

  return this
end function


function TestSuite__UIDialog__SetUp()

  m.scene = GetScene()
  m.dialogContainer = m.scene.findNode("dialogContainer")

  m.dialog = CreateObject("roSGNode", "uiDialog")
  m.dialog.dialogSize = [ 1280, 720 ]

end function

function TestSuite__UIDialog__TearDown()
  m.dialog = invalid
  m.scene = invalid
  m.dialogContainer = invalid
end function

'********** TEST CASES ***********'

function TestCase__UIDialog_OpenDialogCheck()

  openDialog( m.dialog, m.scene )
  return m.AssertEqual(m.dialogContainer.getChildCount(), 1 )
end function


function TestCase__UIButton_CloseDialogCheck()

  closeDialog( m.scene )
  return m.AssertEqual( m.dialogContainer.getChildCount(), 0 )
end function
