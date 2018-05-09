
function init()

  m.top.id = "categoriesItemComponent"

  m.pstrCategory = m.top.findNode("pstrCategory")
end function

function onContentChange( event as Object )

  content = event.getData()

  m.pstrCategory.uri = content.imageUrl

end function
