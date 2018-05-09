
' Fetch data from local file storage
' NOTE: Does not do any write operations

function fileClient()

  if (not isValid( m.fileClient ))

      m.fileClient = {

        getData: function( fileURI as String ) as Dynamic
            return ReadAsciiFile( fileURI )
        end function
      }

  end if

  return m.fileClient
end function
