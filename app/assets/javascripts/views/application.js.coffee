Founden.ApplicationView = Ember.View.extend
  actions:
    showHideNetwork: (network) ->
      network.toggleProperty('isHidden')
