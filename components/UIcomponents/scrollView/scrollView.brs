
function init()

  m.top.id = "scrollView"
  m.top.observeField("focusedChild", "onFocus")

  constants = GetConstants()
  m.isLowEndDevice = isLowEndDevice()

  m.LAZY_LOAD_THRESHOLD = 5

  m.scrollContainer = m.top.findNode("scrollContainer")
  m.scrollAnimation = m.top.findNode("scrollAnimation")
  m.scrollTranslation = m.scrollAnimation.findNode("scrollTranslation")
  m.scrollTimer = m.top.findNode("scrollTimer")
  m.scheduler = m.top.findNode("scheduler")

  m.scrollAnimation.optional = isLowEndDevice()

  m.scrollTimer.observeField( "fire", "fireScroller" )
  m.scheduler.observeField( "fire", "runTask" )

  m.scheduler.duration = getSchedulerDuration( m.isLowEndDevice, constants )

  m.reserveComponents = []

  m.keyPressedState = invalid
  m.top.currentIndex = 0
end function


'***** FOCUS HANDLERS *****'

function onFocus(event as Object)

  if ( m.top.hasFocus() )

    if ( m.top.children.count() > 0 )
      firstChild = m.top.children[ m.top.currentIndex ]
      if ( isValid( firstChild ) ) then setFocusOnChild( firstChild, " onFocus() - " )
    end if

  end if

end function


function onKeyEvent( key as String, press as Boolean )

  handled = false

  if ( press )

    scrollItemCount = m.scrollContainer.getChildCount()

    if ( LCase(key) = "down" OR LCase(key) = "up" )

      m.keyPressedState = LCase(key)
      scrollItemCount = m.scrollContainer.getChildCount()

      if ( not ((m.top.currentIndex = scrollItemCount - 1 AND m.keyPressedState = "down") OR (m.top.currentIndex = 0 AND m.keyPressedState = "up")) AND scrollItemCount > 0)
        moveScrollView()
        m.scrollTimer.control = "start"

        handled = true
      end if
    end if
  else
    m.scrollTimer.control = "stop"

    currentChild = m.top.children[ m.top.currentIndex ]
    setFocusOnChild( currentChild, "onKeyEvent() - " )

    handled = true
  end if

  return handled

end function

'***** FIELD HANDLERS *****'

function onViewportChange( event as Object )

  size = event.getData()

  if ( size.Count() = 1 )
    size.push( 400 )
  end if

  clippingRect = [ 0, 0 ]
  clippingRect.append( size )

  m.top.clippingRect = clippingRect

end function

function onChildrenChange( event as Object )

  children = event.getData()

  ' Clear previous children
  childCount = m.scrollContainer.getChildCount()
  if ( childCount > 0 )
    m.scrollContainer.removeChildrenIndex(childCount,0)
  end if

  ' load minimal components
  m.reserveComponents = children
  children = arraySlice( children, 0, m.LAZY_LOAD_THRESHOLD )

  m.top.loadedAllChildren = false
  startScheduler()

  yPos = 0

  for each child in children

    child.translation = [ 0, yPos ]
    m.scrollContainer.appendChild( child )

    index = m.scrollContainer.getChildCount()
    padding = paddingForIndex(index)
    bounds = child.boundingRect()
    yPos = yPos + bounds.height + padding

  end for

end function

function onPaddingChange( event as Object )
  padding = event.getData()
end function

function fireScroller( event as Object )
  moveScrollView()
end function

function onScrollTo( event as Object )

  index = event.getData()
  scrollItemCount = m.scrollContainer.getChildCount()

  if ( (index < (scrollItemCount - 1)) AND (index > -1) )

    keyPressedState = "up"
    if ( index > m.top.currentIndex ) then keyPressedState = "down"

    iterations = Abs(m.top.currentIndex - index )

    while ( iterations <> 0 )
      animateView( keyPressedState, scrollItemCount )
      iterations = iterations - 1
    end while

  end if
end function

function resetScrollview( event as Object )

  status = event.getData()

  if ( status )
    m.scrollContainer.translation = [ 0, 0 ]
    m.top.currentIndex = 0
  end if
end function

function runTask( event as Object )
  loadComponents()
end function

'***** HELPERS *****'

' Moves the scrollview up or down based on the set direction
function moveScrollView()

  scrollItemCount = m.scrollContainer.getChildCount()

  if ( not ((m.top.currentIndex = scrollItemCount - 1 AND m.keyPressedState = "down") OR (m.top.currentIndex = 0 AND m.keyPressedState = "up")) AND scrollItemCount > 0)
    animateView( m.keyPressedState, scrollItemCount )
  end if

end function


' Moves the scrollview up and down based on current positon
' @param key as string
' @param scrollItemCount total no of children within scrollview
' @return currentFocusable Index
function animateView( key as String, scrollItemCount as Integer ) as Integer

  direction = 1
  indexDirection = 0
  if ( key="up" )
    direction = -1
    indexDirection = -1
  end if

  padding = paddingForIndex(m.top.currentIndex + direction)

  if ( m.scrollAnimation.state = "running" )
    m.scrollAnimation.control = "finish"
  end if

  displacmentY = m.scrollContainer.getChild( m.top.currentIndex + indexDirection ).boundingRect().height + padding
  newTranslation = [ 0,  m.scrollContainer.translation[1] - (displacmentY * direction) ]

  m.scrollTranslation.keyValue = [ m.scrollContainer.translation, newTranslation ]
  m.scrollAnimation.control = "start"

  m.top.currentIndex = m.top.currentIndex + direction

  return m.top.currentIndex

end function

' set focus on the current child
' @param Object child object
' @param String logging string
' @return boolean true on success or false on failure
function setFocusOnChild( child as Object, log = "" as String )

  status = false

  if ( isValid(child) AND child.focusable )
    applyFocus( child, true, log + "setFocusOnChild() - scrollView.brs" )
    status = true
  end if

  return status

end function

function paddingForIndex(index as Integer) as float

  padding = m.top.padding[m.top.padding.count() - 1]

  if ( not (index >= m.top.padding.count()) )
   padding = m.top.padding[index]
  end if

  return padding
end function

' Appends or lazy load components from reserve
' @param integer totalNoOfVisibleItems on the scrollContainer
function fetchReserveComponents( totalVisibleItems as Integer )

  startIndex = totalVisibleItems
  endIndex = totalVisibleItems + m.LAZY_LOAD_THRESHOLD

  requiredComponents = arraySlice( m.reserveComponents, startIndex, endIndex )

  yPos = ( m.scrollContainer.boundingRect().height ) + paddingForIndex( startIndex )

  for each child in requiredComponents

    child.translation = [ 0, yPos ]
    m.scrollContainer.appendChild( child )

    index = m.scrollContainer.getChildCount()
    padding = paddingForIndex(index)
    bounds = child.boundingRect()
    yPos = yPos + bounds.height + padding
  end for

end function

' Load remaining components
function loadComponents()
  scrollItemCount = m.scrollContainer.getChildCount()

  fetchReserveComponents( scrollItemCount )

  if ( scrollItemCount >= m.reserveComponents.count() )
    stopScheduler()
    m.top.loadedAllChildren = true
  end if

end function

' Starts the scheduler on the controller
function startScheduler()
  m.scheduler.control = "start"
end function

' Stop the scheduler
function stopScheduler()
  m.scheduler.control = "stop"
end function

' Returns scheduler duration based on device type
' @param Boolean true for LOW_END_DEVICE
' @param Object constants
' @return float duration
function getSchedulerDuration( islowDevice as Boolean, constants as Object ) as Float

  if ( islowDevice ) then return constants.SCHEDULER.TIMER_DURATION.LOW_END_DEVICE
  return constants.SCHEDULER.TIMER_DURATION.HIGH_END_DEVICE

end function
