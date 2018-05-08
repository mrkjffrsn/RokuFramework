
' Model representing categories lists'
function CategoriesModel( data as Object )

  model = {

    'Fields
    type: ""
    results: [],

    ' Responsible for creating content nodes'
    createContentNode: function()

      contentNode = CreateObject("roSGNode", "ContentNode")

      contentNode.title = m.type

      for each category in m.results
          contentNode.appendChild( category.createContentNode() )
      end for

      return contentNode

    end function,

    ' Parse data into a model object
    parseData: function( data )

      if ( isValid(data) )
        if ( isValid( data.type ) ) then m.type = data.type

        if ( isArray( data.results ) and data.results.count() > 0 )
            for each category in data.results
              m.results.push( CategoryModel(category) )
            end for
        end if
      end if

    end function
  }

  model.parseData( data )
  return model

end function


' Represents a Category Item'
function CategoryModel( data )

  model = {

    id: "",
    title: "",
    imageUrl: "",

    createContentNode: function()

      contentNode = CreateObject("roSGNode", "CategoryModel")

      contentNode.id = m.id
      contentNode.title = m.title
      contentNode.imageUrl = m.imageUrl

      return contentNode

    end function,

    parseData: function( data )

      if (isValid(data))

        if ( isValid( data.id ) ) then m.id = data.id
        if ( isValid( data.title ) ) then m.title = data.title
        if ( isValid( data.imageUrl ) ) then m.imageUrl = data.imageUrl

      end if

    end function

  }

  model.parseData( data )
  return model

end function
