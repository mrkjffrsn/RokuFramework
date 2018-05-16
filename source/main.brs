

' Entry point for App'
function Main(args as Dynamic)

  ' TODO: Deeplinking feature to be added
  constants = GetConstants()

  port = CreateObject("roMessagePort")
  screen = CreateObject("roSGScreen")
  screen.setMessagePort(port)

  scene = screen.CreateScene("BaseScene")
  screen.show()

  ' Listen to any scene port listeners here'

  ' Load first page'
  scene.loadController = { page: constants.CONTROLLERS.HOME, params: { } }

  ' Run Tests
  if ( args.RunTests = "true" and (isValid(TestRunner) and type(TestRunner) = "Function") )
      Runner = TestRunner()
      Runner.logger.SetVerbosity(1)

      if (isValid(args.ip))
        Runner.logger.ip = args.ip
      end if

      Runner.logger.printStatistic = printTestStatistics
      Runner.Run()
  end if

  ' Start the main event loop here'
  mainEventLoop( port )

end function

function mainEventLoop( port )

  while ( true )

    msg = wait(0, port)
    msgType = type(msg)

    ' Handle all the needed events here
    if ( msgType = "roSGScreenEvent" )
      if msg.isScreenClosed() then exit while
    else if ( msgType = "roSGNodeEvent" )
       ' handle SGNode events here
    end if

  end while

end function


function printTestStatistics( stats as Object )

  state = "fail"
  if ( stats.crash = 0 and stats.fail = 0 ) then state = "success"

  if (isValid(m.ip))
    http = CreateObject("roUrlTransfer")
    http.setRequest( "GET" )
    http.setUrl("http://"+m.ip+":3000/rokuTests?state="+state)
    data = http.GetToString()
  else
    print "*************** Test Result : " + state + " ******************* "
    print "Results Object : "; stats
    print "To know more about which testsuite failed, please inspect the stats object"
  end if
end function
