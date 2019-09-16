sub init()

  m.top.id = "UITextEditBox"

  m.FOUCSED_BACKGROUND_URI = "pkg:/images/fhd/textEditBox/txtbox-focused.png"
  m.UNFOCUSED_BACKGROUND_URI = "pkg:/images/fhd/textEditBox/txtbox-nofocus.png"

  m.baseTxtBox = m.top.findNode( "baseTxtBox" )
  m.backgroundImg = m.top.findNode( "backgroundImg" )
  m.top.observeField( "active", "onTextBoxActive" )

end sub

'***** Field Handlers *****

function onKeyEvent( key as String, press as Boolean )

  handled = false

  if ( press )

    if ( LCase( key ) = "ok" )
      m.top.textBoxSelected = true
      handled = true
    end if

  end if

  return handled

end function


'***** Field Observers *****

function onTextChange( event as Object )

  value = event.getData()
  m.baseTxtBox.text = value

end function

function onTextBoxActive( event as Object )

  isActive =  event.getData()

  if ( isActive )
    m.backgroundImg.uri = m.FOUCSED_BACKGROUND_URI
  else
    m.backgroundImg.uri = m.UNFOCUSED_BACKGROUND_URI
  end if

end function
