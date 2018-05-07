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

' Checks if object is a string or not
' @param object string
' @return boolean
function isString( str as String ) as Boolean
  strType = LCase( type(str) )
  return ( strType = "string" ) or ( strType = "rostring" )
end function


' Checks if value is an object or not
' @param object
' @return boolean
function isObject( obj as Object ) as Boolean

  if ( not isValid( obj )) then return false

  objType = LCase( type(obj) )
  return objType = "roassociativearray"
end function


' Checks if value is a Boolean or not
' @param boolean
' @return boolean
function isBoolean( obj as Boolean ) as Boolean
  objType = LCase( type(obj) )
  return ( objType = "boolean" ) or ( objType = "roboolean" )
end function


' Checks if value is an array or not
' @param array
' @return boolean
function isArray( arr as Object ) as Boolean

  if ( not isValid( arr )) then return false

  objType = LCase( type(arr) )
  return ( objType = "roarray" ) or ( objType = "array" )
end function


' Checks if value is an Integer or not
' @param integer
' @return boolean
function isInteger( int as Integer ) as Boolean
  objType = LCase( type(int) )
  return ( objType = "integer" ) or ( objType = "roInteger" )
end function


' Returns a random UUID
' @return String
function generateUUID() as String
  return CreateObject("roDeviceInfo").GetRandomUUID()
end function


' Returns if the device is a low end device or not'
' @return Boolean'
function isLowEndDevice() as Boolean

  lowEndDeviceList = GetConstants().LOW_END_DEVICE

  deviceInfo = CreateObject("roDeviceInfo")
  modelNo = deviceInfo.GetModel()

  return ( deviceInfo.GetGraphicsPlatform() = "directfb" ) or ( lowEndDeviceList.DoesExist(Lcase(modelNo)) )
end function
