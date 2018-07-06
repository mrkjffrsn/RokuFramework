
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

' goes back one level in history
function goBackInHistory( scene = getScene() as Object )
  scene.unloadController = true
end function

' Open a dialog
' @param object dialog node
' @param object scene node
function openDialog( dialog as Object, currentFocusItem as Object, scene = GetScene() as Object )

  if isValid( dialog )
    dialogContainer = scene.findNode( "dialogContainer" )
    dialogContainer.removeChildrenIndex( dialogContainer.getChildCount(), 0 )
    dialogContainer.appendChild( dialog )

    dialogBounds = dialog.boundingRect()
    dialog.translation = [ Abs(( 1920 - dialogBounds.width ) / 2), Abs((1080 - dialogBounds.height) / 2) ]

    dialog.parentFocusItem = currentFocusItem
    applyFocus( dialog, true, "setDialog() - sceneUtils.brs" )
  end if

end function

' Close a dialog
' @param object scene node
function closeDialog( scene = GetScene() as Object )

  dialogContainer = scene.findNode( "dialogContainer" )
  dialog = dialogContainer.getChild( 0 )

  dialogContainer.removeChildrenIndex( dialogContainer.getChildCount(), 0 )

  applyFocus( dialog.parentFocusItem, true, "closeDialog() - sceneUtils.brs" )
end function
