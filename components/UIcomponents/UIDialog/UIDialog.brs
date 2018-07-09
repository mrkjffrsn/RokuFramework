
function init()

  m.top.id = "uiDialog"

  m.baseRect = m.top.findNode( "baseRect" )

  m.top.observeField( "focusedChild", "onDialogFocused" )

end function

'***** Key Handlers *****

function onKeyEvent( key as String, press as Boolean )

  handled = false

  if ( press )

    if ( key = "back" )
      closeDialog()
      handled = true
    end if

  end if

  return handled

end function

'***** Field Observers *****

function onDialogFocused( event as Object )
end function

function onClose( event as Object )

  m.top.unobserveField( "focusedChild" )
end function

function onDialogSizeChange( event as Object )

  size = event.getData()

  m.baseRect.width = size[0]
  m.baseRect.height = size[1]
end function

'***** Helpers *****

' Set modals background color
' @param string color reference
function setBackgroundColor( color = "#ffffffff" as String )
  m.baseRect.color = color
end function
