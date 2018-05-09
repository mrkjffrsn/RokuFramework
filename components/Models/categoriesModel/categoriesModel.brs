
function init()
  m.top.id = "CategoriesModel"
end function

' parses data and injects into it's own properties
' @param Data object'
function parseData( data )

  if ( isValid(data) )
    if ( isValid( data.type ) ) then m.top.title = data.type

    if ( isArray( data.results ) and data.results.count() > 0 )
        for each category in data.results
          node = CreateObject("roSGNode", "CategoryModel")
          node.callfunc("parseData", category)
          m.top.appendChild( node )
        end for
    end if
  end if

end function
