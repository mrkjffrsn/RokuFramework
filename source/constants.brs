
' Contains a list of constants and enums for the application'

function GetConstants()

  if (not isValid(m.constants))
    m.constants = {

      ' App navigation types
      NAVIGATION_TYPES: {
        NAVIGATE_TO : "NAVIGATE_TO",
        NAVIGATE_AWAY : "NAVIGATE_AWAY"
      },

      ' App Controllers
      CONTROLLERS: {
        HOME: "HomeController"
      },

      ' HTTP Types'
      HTTP_TYPES: {
        GET: "GET",
        POST: "POST",
        DELETE: "DELETE",
        PUT: "PUT"
      }

    }
  end if

  return m.constants
end function
