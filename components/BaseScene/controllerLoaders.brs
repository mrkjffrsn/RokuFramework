'*********** Controller Load and Unload parameters *************'

function onLoad( event as Object )

  pageInfo = event.getData()

  initiateNavigationAway( m.top.currentController, m.navigationStack.Count() > 0 )

  if ( (not isValid(pageInfo.skipHistory)) or (isValid(pageInfo.skipHistory) and not pageInfo.skipHistory) )
    m.navigationStack.push( pageInfo )
  end if

  attachController( pageInfo )
end function


function onUnLoad( event as Object )

  isPagePopping = event.getData()

  if (isPagePopping)

    pageInfo = getNextPageInfo()

    initiateNavigationAway( m.top.currentController )

    if (isValid(pageInfo))
      attachController( pageInfo )
    end if
  end if

end function


' Loads the controller and attaches it to the scene'
function attachController( pageInfo as Object )

    constants = GetConstants()
    controller = CreateController( pageInfo.page )

    if (isValid(controller))

      m.controllerView.removeChildIndex(0)
      m.controllerView.insertChild( controller, 0 )

      m.top.currentController = controller
      controller.onNavigationEvent = { type: constants.NAVIGATION_TYPES.NAVIGATE_TO, params: pageInfo.params }

    end if
end function

function initiateNavigationAway( currentController, saveState = false as Boolean )

  constants = GetConstants()

  if (isValid(currentController))

    currentController.onNavigationEvent = { type: constants.NAVIGATION_TYPES.NAVIGATE_AWAY }

    if ( saveState AND isValid( currentController.controllerState ) )
      pageInfo = m.navigationStack.peek()
      if ( pageInfo.page = currentController.id ) then pageInfo.params[ "controllerState" ] = currentController.controllerState
    end if

  end if
end function

' Returns the next page params. If no page, then returns invalid'
'@return Object'
function getNextPageInfo() as Object

  nextController = m.navigationStack.pop()

  'if the next controller is the same as the current controller. Then pick the next controller from stack again.
  if ( isValid(nextController) AND m.top.currentController.id = nextController.page )
    nextController = m.navigationStack.peek()
  end if

  return nextController
end function

' Clears out the navigation stack
function clearNavigationStack()
  m.navigationStack = []
end function
