function init()

  m.top.id = "RegistryTask"
  m.top.functionName = "startRegistryTask"

end function

function startRegistryTask()

  action = m.top.action
  data = m.top.data
  constants = GetConstants()

  if ( isValid( action ) and isValid( data ) and isValid( data.registry ) )

    registry = CreateObject("roRegistrySection", data.registry )

    if ( action = constants.REGISTRY_ACTION_TYPES.READ )
      value = readRegistry( registry, data.key )
      m.top.response = { data: value }
    else if ( action = constants.REGISTRY_ACTION_TYPES.WRITE )
      writeRegistry( registry, data.data )
    else if ( action = constants.REGISTRY_ACTION_TYPES.DELETE )
      deleteRegistry( registry, data.key )
    end if

  end if

  m.top.Control = "STOP"

end function

' Finds an element from the given registry
' @param registry object
' @param key string
' @return Value as string or invalid if not found
function readRegistry( Registry as Object, key as String )

  if Registry.Exists(key)
    return Registry.Read(key)
  end if

  return invalid
end function

' writes an element from the given registry
' @param registry object
' @param associative array - only key / value pairs
function writeRegistry( Registry as Object, data as Object )

  for each key in data
    Registry.Write(key, data[key])
  end for

  Registry.Flush()
end function

' deletes an element from the given registry
' @param registry object
' @param key string
function deleteRegistry( Registry as Object, key as String )

  if Registry.Exists(key)
    Registry.Delete(key)
    Registry.Flush()
  end if
end function
