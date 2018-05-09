

function categoriesService()

  if ( not isValid( m.service ))

    m.service = {

      getCategories: function( callback as function, params = invalid as Object )

        data = ParseJson(ReadAsciiFile("pkg:/data/categories.json"))

        model = CreateObject("roSGNode", "CategoriesModel")
        model.callfunc("parseData", data )

        callback( model, params )
      end function
    }

  end if

  return m.service
end function
