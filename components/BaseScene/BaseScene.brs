
' Code Behind for BaseScene'

function Init()

  m.top.id = "BaseScene"

  m.controllerView = m.top.findNode("controllerView")

  ' Construct Base Scene Here '
  m.navigationStack = []

  SetupHttpListener()
end function


'Creates and set's the http task node
function SetupHttpListener()

  httpTask = CreateObject("roSGNode", "HttpTask")
  httpTask.control = "RUN"
  m.top.httpTask = httpTask
end function
