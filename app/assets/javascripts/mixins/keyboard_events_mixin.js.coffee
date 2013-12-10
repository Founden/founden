Founden.KeyboardEventsMixin = Ember.Mixin.create
  keyPressEvent: null
  keyCodes:
    at:
      aka: '@'
      code: 50
      shift: true
    plus:
      aka: '+'
      code: 187
      shift: true
    arrowDown:
      code: 40
      shift: false
    arrowUp:
      code: 38
      shift: false

  # Hook to be called when `@` key is pressed
  onAtKeyPress: Ember.K

  # Hook to be called when `+` key is pressed
  onPlusKeyPress: Ember.K

  # Hook to be called on any key press
  onAnyKeyPress: Ember.K

  # Handles keyboard events
  keyPressEventChanged: ( ->
    event = @get('keyPressEvent')
    at = @get('keyCodes.at')
    plus = @get('keyCodes.plus')
    textarea = event.target

    @onAnyKeyPress(textarea)

    if event and at.code == event.which and at.shift == event.shiftKey
      @onAtKeyPress(textarea)

    # Might not work in FF
    if event and plus.code == event.which and plus.shift == event.shiftKey
      @onPlusKeyPress(textarea)
  ).observes('keyPressEvent')
