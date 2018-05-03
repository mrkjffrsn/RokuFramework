
'*********** Controller Load and Unload parameters *************'

function onLoad( event as Object )

  pageParams = event.getData()

  initiateOnNavigationAway( m.top.currentController )

  m.navigationStack.push( pageParams )

  attachController( pageParams )
end function


function onUnLoad( event as Object )

  params = event.getData()

  pageParams = getNextPageParams()

  if (params)
    if ( isValid(pageParams.ignoreOnBack) and pageParams.ignoreOnBack )
      pageParams = getNextPageParams()
    end if

    initiateOnNavigationAway( m.top.currentController )

    if (isValid(pageParams))
      attachController( pageParams )
    end if
  end if
end function


' Loads the controller and attaches it to the scene'
function attachController( pageParams as Object )

    constants = GetConstants()
    controller = CreateController( pageParams.page )

    if (isValid(controller))

      controller.onNavigationEvent = { type: constants.NAVIGATION_TYPES.NAVIGATE_TO, params: pageParams.params }

      m.controllerView.removeChildIndex(1)
      m.controllerView.insertChild( controller, 1 )
      m.top.currentController = controller

    end if
end function

function initiateOnNavigationAway( currentController )

  constants = GetConstants()

  'TODO:Figure out a way to update state values of pageParams'

  if (isValid(currentController))
    currentController.onNavigationEvent = { type: constants.NAVIGATION_TYPES.NAVIGATE_AWAY }
  end if
end function

' Returns the next page params. If no page, then returns invalid'
'@return Object'
function getNextPageParams() as Object
  m.navigationStack.pop()
  return m.navigationStack.peek()
end function
