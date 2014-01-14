Founden.TextAreaCaretMixin = Ember.Mixin.create Founden.KeyboardEventsMixin,
  caret: Ember.Object.create
    top: 0
    left: 0

  # Overwrites KeyboardEventsMixin hook
  onAnyKeyPress: (textarea) ->
    @updateCaretOffset(textarea)

  # Updates the textarea caret offset
  updateCaretOffset: (textarea) ->
    # This is the mirror of the textarea
    mirror = $('<div></div>')
    # And this is the caret of the mirrored textarea
    cursor = $('<em></em>').text('|')
    # Prepare content
    text = @textBeforeCaret(textarea)
    # - make whitespace countable
    space_regex = new RegExp(' ', 'g')
    text = text.replace(space_regex, '.')
    # Set the content of the textarea
    mirror.text(text)
    # Set the same class names
    mirror.addClass($(textarea).attr('class'))
    # Hide mirror
    mirror.css
      position: 'relative',
      top: 0,
      left: -9999,
      overflow: 'auto',
      'white-space': 'pre-line'

    cursor.appendTo(mirror)

    $(textarea).before(mirror)

    # Now just capture its position
    position = cursor.position()
    cursor.remove()
    mirror.remove()

    @set('caret.top', position.top + cursor.height() - textarea.scrollTop)
    @set('caret.left', position.left)

  # Returns currently selected text
  textBeforeCaret: (textarea) ->
    # Sane browsers
    if textarea.selectionEnd
      return textarea.value.substring(0, textarea.selectionEnd)
    # IE
    else if document.selection
      range = textarea.createTextRange()
      range.moveStart('character', 0)
      range.moveEnd('textedit')
      return range.text
    # lynx
    else
      textarea.value

  appendAfterCarret: (textarea, textToAppend) ->
    newValue = @textBeforeCaret(textarea)
    # Remove last typed character
    newValue = newValue.substring(0, newValue.length - 1)
    oldValue = textarea.value

    # Snapshot old caret position including last character
    caretPosition = newValue.length + 1
    newValue += textToAppend

    # Snapshot the new position inside textarea
    newCaretPosition = newValue.length

    newValue += oldValue.substring(caretPosition, oldValue.length)
    textarea.value = newValue
    textarea.selectionStart = textarea.selectionEnd = newCaretPosition
