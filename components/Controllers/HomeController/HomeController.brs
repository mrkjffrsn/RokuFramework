function init()

  m.top.id = "HomeController"

end function

' LIFE CYCLE METHODS '

function onNavigateTo( params as Object )

end function

function onNavigateAway( params as Object )
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
    callback: onHomePageLoad,
    callbackParams: { page: "HomePage" }
  }

  m.http.sendRequest( request )

 end function

' Homepage callback'
function onHomePageLoad( data, params )

end function
