

function categoriesService()

  if ( not isValid( m.service ))

    m.service = {

      getCategories: function( callback as function, params = invalid as Object )

        data = ParseJson(ReadAsciiFile("pkg:/data/categories.json"))

        model = CategoriesModel( data )
        categoriesData = model.createContentNode()
        callback( categoriesData, params )
      end function
    }

  end if

  return m.service
end function
