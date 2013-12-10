Founden.NetworksComposeRoute = Ember.Route.extend

  setupController: (controller, model) ->
    conversation = @store.createRecord('conversation')
    controller.set('network', model)
    controller.set('content', conversation)
