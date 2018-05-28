
function registryClient()

  if ( not isValid( m.registryClient ) )

    m.registryClient = {

      readKeys: { },
      constants: GetConstants(),

      read: function( registryName as String, key as String, callback as function )

        m.readKeys[ key ] = callback

        m.regTask = CreateObject("roSGNode", "RegistryTask")
        m.regTask.action = m.constants.REGISTRY_ACTION_TYPES.READ
        m.regTask.data = { key: key, registry: registryName }
        m.regTask.observeField( "response", "onRegistryRead" )
        m.regTask.Control = "RUN"

      end function,

      write: function( registryName as String, data as Object )

        m.regTask = CreateObject("roSGNode", "RegistryTask")
        m.regTask.action = m.constants.REGISTRY_ACTION_TYPES.WRITE
        m.regTask.data = { data: data, registry: registryName }
        m.regTask.Control = "RUN"

      end function,

      deleteItem: function( registryName as String, key as String )

        m.regTask = CreateObject("roSGNode", "RegistryTask")
        m.regTask.action = m.constants.REGISTRY_ACTION_TYPES.DELETE
        m.regTask.data = { key: key, registry: registryName }
        m.regTask.Control = "RUN"

      end function
    }

  end if

  return m.registryClient
end function


function onRegistryRead( event as Object )

  readResponse = event.getData()
  regTask = event.getRoSGNode()

  regClient = registryClient()
  regClient.readKeys[ regTask.data.key ]( readResponse )
  regClient.readKeys.Delete( regTask.data.key )
  regClient.regTask.unObserveField("response")

end function
