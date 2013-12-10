Founden.ScrollEventsMixin = Ember.Mixin.create
  onScroll: Ember.K

  registerOnScroll: ->
    $(window.document).on 'touchmove', =>
      Ember.run.debounce @, 'onScroll', 100
    $(window).on 'scroll', =>
      Ember.run.debounce @, 'onScroll', 100

  didInsertElement: ->
    @registerOnScroll()
