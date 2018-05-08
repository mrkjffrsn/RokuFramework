function init()

  m.top.id = "HomeController"

  m.rwlstCategories = m.top.findNode("rwlstCategories")
end function

' LIFE CYCLE METHODS '

function onNavigateTo( params as Object )
  categoriesService().getCategories( onCategoriesDataLoad )
end function

function onNavigateAway( params as Object )
end function


' PAGE HELPER METHODS '

' Async categories callback
' @param Object data
' @param Object callback parameters'
function onCategoriesDataLoad( data, params )

  rowListData = CreateObject( "roSGNode", "ContentNode" )
  rowListData.appendChild( data )

  m.rwlstCategories.content = rowListData
  m.rwlstCategories.setFocus(true)
end function
