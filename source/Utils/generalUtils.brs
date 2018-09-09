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

' Capitalizes the first letter of the given text
' @param string text
' @return string text
function CapitalizeString( text = "" as String )

  returnValue = ""

  for each word in text.Tokenize( " " )
    returnValue += CapitalizeWord( word ) + " "
  end for

  return Left(returnValue, Len(returnValue) - 1 )
end function

' Capitalizes the first letter of the given text
' @param string text
' @return string text
function CapitalizeWord( text = "" as String )
  return UCase( Left(text, 1) ) + LCase( Right( text, Len(Text) - 1) )
end function


' Creates a shallow copy of a given node
' @param object item
' @return object new item
function shallowNodeCopy( item as Object )

  copy = CreateObject( "roSGNode", item.subtype() )

  fields = item.getFields()

  ' NOTE: Had to do this. This stops warnings thrown by Roku
  fields.Delete( "change" )
  fields.Delete( "focusedChild" )

  copy.setFields( fields )
  return copy

end function


' Returns the query joining symbol ( & or ? )
' @param string url
' @return string symbol ( & or ? )
function getQueryStringSymbol( url as String )

  symbol = "&"
  if ( ( isValid( url ) ) AND ( url.Instr("?") = -1 ) ) then symbol = "?"

  return symbol
end function


' Strips html <p> and &amp from strings
' @param string s as string
' @return string cleaned String
function stripHTMLFromString( s )

  if ( not isValid(s) )
    return ""
  end if

  tagsRegEx = CreateObject( "roRegex", "<[a-zA-Z\/][^>]*>", "m" )
  s = tagsRegEx.ReplaceAll( s, "" )

  entitiesRegEx = CreateObject( "roRegex", "(&[a-zA-Z]*;)", "m" )
  s = entitiesRegEx.ReplaceAll( s, "" )

  return s

end function
