
function init()

  m.top.id = "scrollView"
  m.top.observeField("focusedChild", "onFocus")

  m.scrollContainer = m.top.findNode("scrollContainer")
  m.scrollAnimation = m.top.findNode("scrollAnimation")
  m.scrollTranslation = m.scrollAnimation.findNode("scrollTranslation")
  m.scrollTimer = m.top.findNode("scrollTimer")

  m.scrollTimer.observeField("fire", "fireScroller")

  m.keyPressedState = invalid
  m.currentIndex = 0
end function


'***** FOCUS HANDLERS *****'

function onFocus(event as Object)

  if ( m.top.hasFocus() )

    if ( m.top.children.count() > 0 )
      firstChild = m.top.children[0]
      setFocusOnChild( firstChild, " onFocus() - " )
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

      if ( not ((m.currentIndex = scrollItemCount - 1 AND m.keyPressedState = "down") OR (m.currentIndex = 0 AND m.keyPressedState = "up")) AND scrollItemCount > 0)
        moveScrollView()
        m.scrollTimer.control = "start"

        handled = true
      end if
    end if
  else
    m.scrollTimer.control = "stop"

    currentChild = m.top.children[ m.currentIndex ]
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

  m.scrollContainer.appendChildren( children )

end function

function onPaddingChange( event as Object )

  padding = event.getData()

  m.scrollContainer.itemSpacings = padding
end function

function fireScroller( event as Object )
  moveScrollView()
end function

'***** HELPERS *****'

' Moves the scrollview up or down based on the set direction
function moveScrollView()

  scrollItemCount = m.scrollContainer.getChildCount()

  if ( not ((m.currentIndex = scrollItemCount - 1 AND m.keyPressedState = "down") OR (m.currentIndex = 0 AND m.keyPressedState = "up")) AND scrollItemCount > 0)
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

  padding = m.top.padding[m.top.padding.count() - 1]

  if ( not (m.currentIndex >= m.top.padding.count()) )
   padding = m.top.padding[m.currentIndex]
  end if

  if ( m.scrollAnimation.state = "running" )
    m.scrollAnimation.control = "finish"
  end if

  displacmentY = m.scrollContainer.getChild( m.currentIndex + indexDirection ).boundingRect().height + padding
  newTranslation = [ 0,  m.scrollContainer.translation[1] - (displacmentY * direction) ]

  m.scrollTranslation.keyValue = [ m.scrollContainer.translation, newTranslation ]
  m.scrollAnimation.control = "start"

  m.currentIndex = m.currentIndex + direction

  return m.currentIndex

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
