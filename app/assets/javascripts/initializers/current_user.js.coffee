Founden.initializer
  name: 'currentUser'
  initialize: (container, application)->
    # Wait until all the promises are resolved
    application.deferReadiness()

    container.resolve('model:user').fetch('mine').then (user) ->
      window.me = user
      # Register the `user:current` namespace
      container.register(
        'user:current', user, {instantiate: false, singleton: true})
      # Inject the namespace into controllers and routes
      container.injection('route', 'currentUser', 'user:current')
      container.injection('controller', 'currentUser', 'user:current')

      # Continue the boot process
      application.advanceReadiness()
