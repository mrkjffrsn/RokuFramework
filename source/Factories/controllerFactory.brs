
' Factory method to create controllers'
function CreateController( controllerName as String ) as Dynamic

  ' Do some additional work when needed

  controller = CreateObject("roSGNode", controllerName )
  return controller

end function
