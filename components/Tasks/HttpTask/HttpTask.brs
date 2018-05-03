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


function handleHTTPRequest( event )

  ' Get the request data and fire
  request = event.getData()

  httpTransfer = createObject("roUrlTransfer")

  ' Add Roku cert for HTTPS requests
  if ( request.url.left(6) = "https:" )
      httpTransfer.setCertificatesFile("common:/certs/ca-bundle.crt")
      httpTransfer.initClientCertificates()
  end if

  httpTransfer.setHeaders(request.headers)
  httpTransfer.enableEncodings(true)
  httpTransfer.retainBodyOnError(true)
  httpTransfer.setRequest(request.method)
  httpTransfer.enableCookies()
  httpTransfer.setUrl(request.url)
  httpTransfer.setPort(m.port)

  reqMethod = request.method

  if (reqMethod = m.HTTP_TYPES.GET or reqMethod = m.HTTP_TYPES.DELETE)
      success = httpTransfer.asyncGetToString()
  else if (reqMethod = m.HTTP_TYPES.POST or reqMethod = m.HTTP_TYPES.PUT)
      success = httpTransfer.asyncPostFromString(request.data)
  end if

  if (success)
      identity = httpTransfer.getIdentity()

      job = { httpTransfer: httpTransfer, request: request }
      m.jobs[identity.toStr()] = job
  else
      error = { error: true, code: 10, msg: "Failed to create request for : " + request.url, request: request }
      m.top.response = error
  end if

end function


function handleHTTPResponse( event )

  ' Get the data and send it back
  transferComplete = (event.getInt() = 1)

  if (transferComplete)
      code = event.getResponseCode()
      identity = event.GetSourceIdentity()
      job = m.jobs.Lookup(identity.toStr())

      if ((code >= 200) and (code < 300) and isValid(job))

          body = event.GetString()

          ' TODO: Add xml parsing'
          data = ParseJson(body)

          m.top.response = { error: false, code: code, data: data, request: job.request }

          m.jobs.Delete(identity.toStr())
      else

        error = { error: true, code: code, msg: event.GetFailureReason(), request: job.request }
        m.top.response = error

        m.jobs.Delete(identity.toStr())
      end if
  end if

end function
