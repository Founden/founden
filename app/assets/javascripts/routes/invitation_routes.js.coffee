Founden.InvitationsNewRoute = Ember.Route.extend
  setupController: (controller, model) ->
    invitation = @container.resolve('model:invitation').create()
    controller.set('content', invitation)
