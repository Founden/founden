Founden.initializer
  name: 'updates'
  initialize: (container, application)->
    return if (/127.0.0.1/).test(window.location.href) and
      !(/use_websockets/).test(window.location.href)
    return unless window.WebSocket

    adapter = container.lookup('adapter:application')
    store = container.lookup('store:main')

    endpoint = 'ws://%@%@'.fmt(
      window.location.host, adapter.buildURL('updates'))

    # Register the container namespace
    socket = new WebSocket(endpoint)
    socket.onmessage = (event) ->
      if event.data.length
        # TODO: Manually append conversations and messages to avoid hicups
        #       in rendering of the conversation thread
        data = $.parseJSON(event.data)
        store.pushPayload('message', data)
