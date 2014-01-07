Founden.IndexRoute = Ember.Route.extend

  redirect: (model) ->
    @transitionTo('conversations')
