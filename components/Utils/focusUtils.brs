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

' Creates a focus map for all components
' @param - Object - An array of focusable components on the view
' @return - Associative array - Focus Map Object'
' Sample focus map : { comp: { up: invalid, down: invalud, left: invalid, right: 'componentname' } }'
function createFocusMap( components as Object ) as Object

  focusMap = { }

  for i = 0 to ( components.count() - 1 )
    component = components[ i ]

    componentMap = CreateComponentMap( component, components )
    focusMap[ component.id ] = componentMap
  end for

  return focusMap
end function

' Creates a single focus map for the given component
' @param Component
' @param Array Components
function CreateComponentMap( component, components )

  map = { "up": invalid, "down": invalid, "left": invalid, "right": invalid }

  currentMids = getMidpointCoords(component)

  for i = 0 to ( components.Count() - 1 )

    otherComponent = components[ i ]
    if ( (component.id <> otherComponent.id) and (otherComponent.focusable) )
      otherMids = getMidpointCoords(otherComponent)

      if ( otherMids.x > currentMids.x )
        compareComponentCoords( otherComponent, map, "right", false, components )
      else if ( otherMids.x < currentMids.x )
        compareComponentCoords( otherComponent, map, "left", true, components )
      end if

      if ( otherMids.y > currentMids.y )
        compareComponentCoords( otherComponent, map, "down", false, components )
      else if ( otherMids.y < currentMids.y )
        compareComponentCoords( otherComponent, map, "up", true, components )
      end if

    end if

  end for

  return map

end function

' Compares componets and sets it
' @Param node in inspection
' @param map component focusMap
' @param string direction string
' @param bool sign to state if less or greater than comparisson
function compareComponentCoords( otherComponent as Object, map as Object, direction as String, sign as Boolean, components as Object )

  otherMids = getMidpointCoords(otherComponent)

   position = "x"
  if ( direction = "up" OR direction = "down" )
    position = "y"
  end if

  if ( not isValid(map[direction]) )
    map[direction] = otherComponent.id
  else
    existingCmpMids = getMidpointCoords( findComponent( map[direction], components ) )

    if ( sign and ( otherMids[position] > existingCmpMids[position] ) )
      map[direction] = otherComponent.id
    else if ( otherMids[position] < existingCmpMids[position] )
      map[direction] = otherComponent.id
    end if

  end if

end function

' Returns the midpoint of the component
' @param node
function getMidpointCoords( component )

  bounds = component.boundingRect()

  midx = bounds.x + ( bounds.width/2 )
  midy = bounds.y + ( bounds.height/2 )

  return { x: midx, y: midy }

end function

function findComponent( name, components )

  for i = 0 to components.Count() - 1

    cmp = components[ i ]
    if ( cmp.id = name ) return cmp
  end for

  return invalid

end function
