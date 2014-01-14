Founden.InvitationsNewRoute = Ember.Route.extend
  setupController: (controller, model) ->
    invitation = @store.createRecord 'invitation',
    controller.set('content', invitation)
