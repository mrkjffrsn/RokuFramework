

function categoriesService()

  if ( not isValid( m.service ))

    m.service = {

      getCategories: function( callback as function, params = invalid as Object )

        model = fileClient().getData( "pkg:/data/categories.json", "CategoriesModel" )
        callback( model, params )

      end function
    }

  end if

  return m.service
end function
