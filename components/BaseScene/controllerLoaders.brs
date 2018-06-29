
'*********** Controller Load and Unload parameters *************'

function onLoad( event as Object )

  pageInfo = event.getData()

  initiateNavigationAway( m.top.currentController, m.navigationStack.Count() > 0 )

  m.navigationStack.push( pageInfo )

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

  m.navigationStack.pop()
  nextController = m.navigationStack.peek()

  while ( isValid( nextController ) AND isValid( nextController.skipHistory ) AND ( nextController.skipHistory = true ) )
    m.navigationStack.pop()
    nextController = m.navigationStack.peek()
  end while

  return nextController
end function

' Clears out the navigation stack
function clearNavigationStack()
  m.navigationStack = []
end function
