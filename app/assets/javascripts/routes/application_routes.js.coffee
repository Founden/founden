Founden.IndexRoute = Ember.Route.extend
  redirect: (model)->
    @store.find('user', 'mine').then (user) =>
      @transitionTo('networks.show', user.get('networks.firstObject'))
