
' Code Behind for BaseScene'
function Init()

  m.top.id = "BaseScene"

  m.controllerView = m.top.findNode("controllerView")

  ' Construct Base Scene Here '
  m.navigationStack = []

  SetupHttpListener()
end function


'Creates a HTTP Task
function SetupHttpListener()

  httpTask = CreateObject("roSGNode", "HttpTask")
  httpTask.control = "RUN"
  m.top.httpTask = httpTask
end function
