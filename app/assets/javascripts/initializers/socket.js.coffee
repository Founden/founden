Founden.initializer
  name: 'socket'
  initialize: (container, application)->
    return if (/127.0.0.1/).test(window.location.href) and
      !(/use_websockets/).test(window.location.href)
    return unless window.WebSocket

    adapter = container.lookup('adapter:application')
    store = container.lookup('store:main')

    endpoint = 'ws://%@%@'.fmt(
      window.location.host, adapter.buildURL('', 'socket'))

    # Register the container namespace
    socket = new WebSocket(endpoint)
    socket.onmessage = (event) ->
      if event.data.length
        data = $.parseJSON(event.data)

        # Try a later reload to see if there are any messages
        if data and data.message
          Ember.run.later {store: store, data: data}, (->
            @store.find('message', @data.message.id).then (message) ->
              message.didLoadFromPayload()
          ), 500

        store.pushPayload('message', data)
