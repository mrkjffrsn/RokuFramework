'---------------------------------------------'
' FOCUS UTILS '
'---------------------------------------------'

'Sets focus on '
function applyFocus(obj as Object, focusState = true as Boolean, log = "" as String )

  if (isValid(obj))

    obj.setFocus(focusState)
    m.currentFocusItem = obj
    print " Setting Focus on component ID " + obj.id + " Log : " + log
  end if
end function


' Creates a focus map for all components
' @param - Object - An array of focusable components on the view
' @return - Associative array - Focus Map Object'
' Sample focus map : { comp: { up: invalid, down: invalud, left: invalid, right: 'componentname' } }'
function createFocusMap( components as Object ) as Object

end function

' Set's the focus on the corresponding item
' @param - String Button key press
' @Param - Object focusMap for that view
' @Param - Object current focussed component
' @return - Boolean returns true if focus has been set to a component, false otherwise
function componentFocusHandler( key, focusMap, currentFocusedComponent ) as Boolean

  focusState = false

  if (not isValid( currentFocusedComponent ))
    return false
  end if

  componentFocusMap = focusMap[ currentFocusedComponent.id ]

  if ( isValid( componentFocusMap ) )

    nextFocusedItemId = componentFocusMap[ LCase(key) ]

    if isValid( nextFocusedItemId )
        nextFocusedItem = m.top.findNode( nextFocusedItemId )
        applyFocus( nextFocusedItem, true, m.top.id + " componentFocusHandler() - componentFocusHandler.brs " )
        focusState = true
    else
        focusState = false
    end if
  end if

  return focusState

end function
