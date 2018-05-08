
function init()

  m.top.id = "categoriesItemComponent"

  m.pstrCategory = m.top.findNode("pstrCategory")
  m.lblText = m.top.findNode("lblText")
end function

function onContentChange( event as Object )

  content = event.getData()

  m.lblText.text = content.title
  m.pstrCategory.uri = content.imageUrl

end function
