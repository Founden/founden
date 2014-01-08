Founden.MentionsSupportComponent = Ember.Component.extend Founden.TextAreaCaretMixin,
  classNames: ['mentions']
  isVisible: false

  search: ''
  selectedIndex: 0

  textarea: null
  results: null

  # Overwrites KeyboardEventsMixin hook
  onAtKeyPress: (textarea) ->
    @set('textarea', textarea)
    @set('isVisible', true)

  searchView: Ember.TextField.extend Founden.FuzzySearchMixin,
    # Overwrites FuzzySearchMixin hook
    onInsertNewline: ->
      content = @get('parentView.content')
      index = @get('parentView.selectedIndex')
      if item = content.objectAt(index)
        @get('parentView').appendMention(item)
        @set('parentView.isVisible', false)

    # Overwrites FuzzySearchMixin hook
    onArrowUp: ->
      if @get('parentView.selectedIndex') > 0
        @decrementProperty('parentView.selectedIndex')
        true

    # Overwrites FuzzySearchMixin hook
    onArrowDown: ->
      index = @get('parentView.selectedIndex')
      contentLength = @get('parentView.content.length') - 1
      if index < contentLength
        @incrementProperty('parentView.selectedIndex')
        true

  mentionView: Ember.View.extend
    mention: null
    tagName: 'li'
    classNameBindings: ['mention.isSelected:active']

    click: ->
      @get('parentView').appendMention(@get('mention'))

  searchChanged: ( ->
    search = @get('search')
    results = @get('results')
    content = []
    if search and results and results.get('length') > 0
      @set('selectedIndex', 0)
      searchRegexp = new RegExp(search, 'i')
      content = results.filter (member) ->
        searchRegexp.test member.get('name').toLowerCase()
    else
      @set('selectedIndex', -1)

    @set('content', content)
  ).observes('search', 'results')

  caretChanged: ( ->
    @$().css
      top: @get('caret.top')
      left: @get('caret.left')
  ).observes('caret.top', 'caret.left')

  becameHidden: ->
    @set('search', null)
    # Trigger tab to switch to parent input
    $('[tabindex="1"]').focus()

  selectedIndexChanged: ( ->
    index = @get('selectedIndex')
    content = @get('content')

    return if index < 0

    item = content.objectAt(index)
    if item
      content.setEach('isSelected', false)
      item.set('isSelected', true)
  ).observes('selectedIndex', 'content')

  appendMention: (user) ->
    mention = user.get('name')
    textarea = @get('textarea')
    @appendAfterCarret(textarea, mention)
    @get('parentView').sendAction('addMember', user)

  didInsertElement: ->
    @set('parentView.mentionsSupport', @)
