
'-------------------------------------------------------
' Contains General Scene Utility methods'
'-------------------------------------------------------

' Returns the rootScene Object
' @return rootScene
function getScene()

  if (not isValid( m.scene ))
    m.scene = m.top.getScene()
  end if

  return m.scene

end function
