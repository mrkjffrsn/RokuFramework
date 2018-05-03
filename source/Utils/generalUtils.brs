'-----------------------------------------------------
' Contains General Utility methods'
'-----------------------------------------------------

' Checks if object is valid or not'
' @param Dynamic entity'
' @return Boolean
function isValid( entity as Dynamic ) as Boolean

  if ( (entity = invalid) or (type(entity) = "roInvalid") )
    return false
  end if

  return true
end function


'Returns a random UUID
'@return String
function generateUUID() as String
  return CreateObject("roDeviceInfo").GetRandomUUID()
end function
