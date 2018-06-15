
function init()

  m.top.id = "UIButton"
  m.top.focusable = true
  m.constants = GetConstants()

  m.stateImage = m.top.findNode("pstrStateImage")

  m.top.observeField("focusedChild", "onFocus")
end function

'****** OnKeyEvent *****'

function onKeyEvent( key as String, press as Boolean )

  handled = false

  if (press)
    if ( key = "OK" )
      m.top.pressed = not m.top.pressed
      handled = true
    end if
  end if

  return handled
end function

'***** Field Handlers *****'

function onFocus( event as Object )
    updateState()
end function

function renderStateImage( event as Object )

  state = event.getData()
  uri = m.top.stateImages[state]
  if ( isValid( uri ) )
    m.stateImage.uri = uri
  end if

end function

function onSizeChange( event as Object )

  size = event.getData()
  m.stateImage.width = size[0]
  m.stateImage.height = size[1]

end function

function updateButtonState( event as Object )

  field = event.getField()
  status = event.getData()

  if ( field = "enabled" and status ) then m.top.focusable = false
  updateState()

end function

function onStateImagesChange( event as Object )

  stateImages = event.getData()

  if ( isValid( stateImages ) and stateImages.Count() > 0 )
    updateState()
  end if

end function

'***** Helpers *****'

' Triggers internal button state to be updated
' @param state
function setState( state as String )

  if ( isValid(state) )
    m.top.state = state
  end if

end function

' Get the current state value
' @param boolean button focus state
' @param boolean button pressed state
' @return string state enum constant
function getState( hasfocus = m.top.hasFocus() as Boolean, isPressed = m.top.pressed as Boolean )

  state = m.constants.UI_BUTTON_STATES.UNFOCUSED

  if ( not m.top.enabled )
    return m.constants.UI_BUTTON_STATES.DISABLED
  end if

  if ( hasFocus )
    state = m.constants.UI_BUTTON_STATES.FOCUSED
    if ( isPressed ) then state = m.constants.UI_BUTTON_STATES.PRESSED_FOCUSED
  else
    if ( isPressed ) then state = m.constants.UI_BUTTON_STATES.PRESSED_UNFOCUSED
  end if

  return state

end function

' Updates the current state
function updateState()
  setState( getState() )
end function
