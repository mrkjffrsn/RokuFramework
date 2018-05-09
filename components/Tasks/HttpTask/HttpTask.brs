function init()

  m.top.id = "HttpTask"
  m.top.functionName = "startHTTPTask"

  ' Create a Message Port'
  m.port = CreateObject("roMessagePort")
  m.top.observeField("request", m.port)

  m.HTTP_TYPES = GetConstants().HTTP_TYPES
  m.jobs = {}

end function

function startHTTPTask()

  while (true)

    event = wait(0, m.port)
    eventType = type(event)

    if ( eventType = "roSGNodeEvent" )
      eventField = event.getField()

      if ( eventField = "request" )
        handleHTTPRequest( event )
      end if
    else if ( eventType = "roUrlEvent" )
        handleHTTPResponse( event )
    end if

  end while

end function

' Handles HTTP requests
' @param Object roSGNode event
function handleHTTPRequest( event )

  ' Get the request data and fire
  request = event.getData()

  httpTransfer = createObject("roUrlTransfer")

  ' Add Roku cert for HTTPS requests
  if ( request.url.left(6) = "https:" )
      httpTransfer.setCertificatesFile("common:/certs/ca-bundle.crt")
      httpTransfer.initClientCertificates()
  end if

  httpTransfer.setHeaders( request.headers )
  httpTransfer.enableEncodings( true )
  httpTransfer.retainBodyOnError( true )
  httpTransfer.setRequest( request.method )
  httpTransfer.enableCookies()
  httpTransfer.setUrl( request.url )
  httpTransfer.setPort( m.port )

  reqMethod = request.method

  if (reqMethod = m.HTTP_TYPES.GET or reqMethod = m.HTTP_TYPES.DELETE)
      success = httpTransfer.asyncGetToString()
  else if (reqMethod = m.HTTP_TYPES.POST or reqMethod = m.HTTP_TYPES.PUT)
      payload = createRequestPayload( request.data, request.headers )
      success = httpTransfer.asyncPostFromString( payload )
  end if

  if (success)
      identity = httpTransfer.getIdentity()

      job = { httpTransfer: httpTransfer, request: request }
      m.jobs[identity.toStr()] = job
  else
      error = { error: true, code: 10, msg: "Failed to create request for : " + request.url, request: request, data: invalid }
      m.top.response = createResponseModel( error )
  end if

end function


' Handles HTTP Responses
' @param object roUrlEvent Object
function handleHTTPResponse( event )

  ' Get the data and send it back
  transferComplete = (event.getInt() = 1)

  if (transferComplete)
      code = event.getResponseCode()
      identity = event.GetSourceIdentity()
      job = m.jobs.Lookup(identity.toStr())

      if ((code >= 200) and (code < 300) and isValid(job))

          ' TODO: Add xml parsing

          body = event.GetString()
          data = ParseJson(body)
          model = convertToModel( data, job.request.modelType )

          response = { error: false, code: code, data: model, request: job.request, msg: "" }
          m.top.response = createResponseModel( response )

          m.jobs.Delete(identity.toStr())
      else

        error = { error: true, code: code, msg: event.GetFailureReason(), request: job.request, data: invalid }
        m.top.response = createResponseModel( error )

        m.jobs.Delete(identity.toStr())
      end if
  end if

end function

' Creates a request payload as set by the content-type'
' @param Object data
' @param Object headers
' @return String
function createRequestPayload( data, headers )

  payload = ""
  contentType = headers["content-type"]

  if (isValid(contentType))

    if ( LCase(contentType) = "application/x-www-form-urlencoded" )
      payload = createQueryString( data, false, true )
    else
      payload = FormatJson( data )
    end if
  end if

  return payload
end function


' Creates a Querystring for the given data object
' @param Object An associative array object contaning key value pairs for each queryString item
' @param Boolean includes the query question mark to the front
' @param Boolean encodes the value portion of the data
function createQueryString( data as Object, includeQuery as Boolean, encodeData as Boolean )

  urlTransfer = createObject("roUrlTransfer")

  queryString = ""
  if ( includeQuery )
    queryString = "?"
  end if

  index = 0
  dataCount = data.Count()

  if (isValid(data))
    for each key in data
      value = data[key]

      if ( encodeData )
        value = urlTransfer.Escape( value.toStr() )
      end if

      index = index + 1

      queryString = queryString + key + "=" + value
      if ( index <> dataCount )
        queryString = queryString + "&"
      end if

    end for
  end if

  return queryString
end function


' Converts objects to data models'
' @param data
' @param parser parser details
' @return object ContentNode model object
function convertToModel( data as Object, modelType as String ) as Object

  model = CreateObject( "roSGNode", modelType )

  if ( not isValid( model ) )
    model = CreateObject( "roSGNode", "BaseModel" )
  end if

  model.callfunc( "parseData", data )

  return model
end function

' Creates a response model
' @param Object
' @return Object ContentNode'
function createResponseModel( response as Object ) as Object

  responseModel = CreateObject("roSGNode", "ResponseModel")
  responseModel.error = response.error
  responseModel.code = response.code
  responseModel.data = response.data
  responseModel.msg = response.msg
  responseModel.request = response.request

  return responseModel
end function
