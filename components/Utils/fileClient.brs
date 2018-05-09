
' Fetch data from local file storage
' NOTE: Does not do any write operations

function fileClient()

  if (not isValid( m.fileClient ))

      m.fileClient = {

        getData: function( fileURI as String, modelType as String ) as Dynamic

          data = ParseJson(ReadAsciiFile( fileURI ))

          model = CreateObject("roSGNode", modelType)
          model.callfunc("parseData", data )

          return model

        end function
      }

  end if

  return m.fileClient
end function
