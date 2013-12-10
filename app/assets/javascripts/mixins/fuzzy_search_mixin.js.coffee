Founden.FuzzySearchMixin = Ember.Mixin.create
    keyCodesBinding: 'parentView.keyCodes'

    isVisibleBinding: 'parentView.isVisible'

    valueBinding: 'parentView.search'
    focusOutBinding: 'cancel'

    onInsertNewline: Ember.K
    onArrowDown: Ember.K
    onArrowUp: Ember.K

    # TODO: Make this less relevant in the bubbling performance!!!
    cancel: (event) ->
      # Run this later if it needs to bubble the click on a mention
      Ember.run.later @, ->
        @set('isVisible', false)
      , 200

    insertNewline: (event) ->
      @onInsertNewline(event)
      false

    keyDown: (event) ->
      arrDown = @get('keyCodes.arrowDown')
      arrUp = @get('keyCodes.arrowUp')
      keyMatched = false

      if arrDown.code == event.which
        keyMatched = @onArrowDown()

      if arrUp.code == event.which
        keyMatched = @onArrowUp()

      if keyMatched
        event.preventDefault()

      return !keyMatched

    becameVisible: ->
      # Trigger tab to switch to focus here
      @$().focus()
