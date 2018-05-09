function init()
  m.top.id = "CategoryModel"
end function

function parseData( data )

  if (isValid(data))

    if ( isValid( data.id ) ) then m.top.id = data.id
    if ( isValid( data.title ) ) then m.top.title = data.title
    if ( isValid( data.imageUrl ) ) then m.top.imageUrl = data.imageUrl

  end if
end function
