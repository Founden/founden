Founden.NetworksComposeRoute = Ember.Route.extend

  setupController: (controller, model) ->
    conversation = @store.createRecord 'conversation',
      network: model
      user: @get('currentUser')

    controller.set('network', model)
    controller.set('content', conversation)
