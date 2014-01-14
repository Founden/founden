Founden.ScrollEventsMixin = Ember.Mixin.create
  onScroll: Ember.K

  debouncedOnScroll: ->
    Ember.run.debounce @, 'onScroll', 100

  registerOnScroll: ->
    $(window.document).on 'touchmove', $.proxy(@debouncedOnScroll, @)
    $(window).on 'scroll', $.proxy(@debouncedOnScroll, @)

  unregisterOnScroll: ->
    $(window.document).off 'touchmove', $.proxy(@debouncedOnScroll, @)
    $(window).off 'scroll', $.proxy(@debouncedOnScroll, @)
