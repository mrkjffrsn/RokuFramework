
' Serves as the main http interface for requesting data
function httpClient()

  if (not isValid(m.httpClient))

    m.httpClient = {

      requests: { },

      scene: getScene(),

      sendRequest: function( req )

        requestQuery = createRequestQuery( req )

        if (isValid(requestQuery))
          m.scene.httpTask.request = requestQuery
          m.requests[requestQuery.id] = req
        end if

      end function,

      init: function()

        m.scene.httpTask.unobserveFieldScoped("response")
        m.scene.httpTask.observeFieldScoped("response", "handleHttpClientResponse")

      end function,

      destory: function()

        m.requests = {}
        m.scene.httpTask.unobserveFieldScoped("response")

      end function
    }

    m.httpClient.init()

  end if

  return m.httpClient

end function


'Http Response Handler - Receives http response and exectues the appropriate callback
'@param object event
function handleHttpClientResponse( event as Object )

  http = httpClient()
  response = event.getData()

  requestParams = response.request

  request = http.requests[requestParams.id]
  if (isValid(request) and isValid(request.callback))
    request.callback( response, request.callbackParams )
  end if

end function


'********************** HTTP HELPERS **********************'

'Validates and returns a valid request object
' @param Object request object
' @return Dynamic Request object if valid, else invalid'
function createRequestQuery( req as Object ) as Dynamic

  requestQuery = invalid

  constants = GetConstants()
  HTTP_TYPES = constants.HTTP_TYPES

  method = HTTP_TYPES.GET
  headers = {}
  queryParams = invalid
  data = invalid
  modelType = "BaseModel"

  if (isValid( req.method )) then method = req.method
  if (isValid( req.headers )) then headers.append( req.headers )
  if (isValid( req.queryParams )) then queryParams = req.queryParams
  if (isValid( req.data )) then data = req.data
  if (isValid( req.modelType )) then modelType = req.modelType

  if (isValid(req.url))
    requestQuery = {
      url: req.url,
      headers: headers,
      queryParams: queryParams,
      data: data,
      method: method,
      id: generateUUID(),
      modelType: modelType
    }
  end if

  return requestQuery
end function
