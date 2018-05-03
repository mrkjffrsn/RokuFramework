
'*********** Controller Load and Unload parameters *************'

function onLoad( event as Object )

  pageInfo = event.getData()

  initiateNavigationAway( m.top.currentController )

  if ( (not isValid(pageInfo.ignoreOnBack)) or (isValid(pageInfo.ignoreOnBack) and not pageInfo.ignoreOnBack) )
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

      controller.onNavigationEvent = { type: constants.NAVIGATION_TYPES.NAVIGATE_TO, params: pageInfo.params }

      m.controllerView.removeChildIndex(1)
      m.controllerView.insertChild( controller, 1 )
      m.top.currentController = controller

    end if
end function

function initiateNavigationAway( currentController )

  constants = GetConstants()

  'TODO:Figure out a way to update state values of pageParams'

  if (isValid(currentController))
    currentController.onNavigationEvent = { type: constants.NAVIGATION_TYPES.NAVIGATE_AWAY }
  end if
end function

' Returns the next page params. If no page, then returns invalid'
'@return Object'
function getNextPageInfo() as Object
  return m.navigationStack.pop()
end function
