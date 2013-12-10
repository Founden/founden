Founden.IndexRoute = Ember.Route.extend
  redirect: (model)->
    @store.find('user', 'mine').then (user) =>
      user.get('networks').then (networks) =>
        network = networks.get('firstObject')
        @transitionTo('networks.show', network)
