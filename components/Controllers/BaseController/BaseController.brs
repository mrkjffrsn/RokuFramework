
function init()

  m.top.id = "BaseController"

end function

' ************** KEY EVENT HANDLERS ***************'

function OnKeyEvent(key as String, press as Boolean) as Boolean

  handled = false

  return handled
end function

'************** NAVIGATION EVENT HANDLERS *****************'

function onNavigationEvent( event as Object )

  navigationParams = event.getData()
  constants = GetConstants()

  if (navigationParams.type = constants.NAVIGATION_TYPES.NAVIGATE_TO)
    onNavigateTo( navigationParams.params )
  else
    onNavigateAway()
  end if
end function

function onNavigateTo( params as Object )
  print "NAVIGATE TO : "; m.top.id
end function

function onNavigateAway( params as Object )
  print "NAVIGATING AWAY FROM PAGE : "; m.top.id
end function
