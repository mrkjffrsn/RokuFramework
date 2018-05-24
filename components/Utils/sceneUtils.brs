
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

'Set's a dialog onto the Main Scene
function setDialog( dialog as Object, scene = GetScene() as Object )

  if isValid( dialog )
    scene.dialog = dialog
  end if

end function

' goes back one level in history
function goBackInHistory( scene = getScene() as Object )
  scene.unloadController = true
end function
