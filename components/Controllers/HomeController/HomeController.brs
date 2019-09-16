function init()

  m.top.id = "HomeController"

end function

' LIFE CYCLE METHODS '

function onNavigateTo( params as Object )

  applyFocus( m.top, true, "onNavigateTo() - HomeController.brs" )
  getHomePageData()

end function

function onNavigateAway()

end function


' PAGE HELPER METHODS '

' Get sample data'
function getHomePageData()

  m.http = httpClient()

  request = {
    method: "GET",
    url: "https://basic-blog.prismic.io/api/v2/documents/search?ref=Wh3rNSEAADqKYyzq",
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    },
    httpResponse: CreateObject("roSGNode", "HttpResponseNode")
  }

  request.httpResponse.observeField("response", "onHomePageLoad")
  m.http.sendRequest( request )

 end function


function onHomePageLoad( event as Object )

  print "Output"; event.getData()

end function
