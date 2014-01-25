Founden.Invitation = DS.Model.extend Founden.TimeAgoMixin,
  gravatar_endpoint: 'https://gravatar.com/%@.json?callback=?'
  gravatarUrl: null
  gravatarName: null
  defaultGravatarUrl: 'http://gravatar.com/avatar/default'

  email: DS.attr('string')
  createdAt: DS.attr('date', readOnly: true, defaultValue: new Date)

  user: DS.belongsTo('user')
  membership: DS.belongsTo('membership')

  emailChanged: ( ->
    @set('gravatarUrl', null)
    @set('gravatarName', null)
    email = @get('email').toString()

    if email.length > 5 and /\S+@\S+\.\S+/.test(email)
      Ember.run.debounce @, 'emailInfo', 200
  ).observes('email')

  emailInfo: ->
    md5_endpoint = @store.adapterFor('').buildURL('', 'md5')

    $.getJSON(md5_endpoint, query: @get('email')).success (data) =>
      @gravatarFor(data.hash)

  gravatarFor: (hash) ->
    gravatar_endpoint = @get('gravatar_endpoint').fmt(hash)
    $.getJSON(gravatar_endpoint).success (data) =>
      @set('gravatarUrl', data.entry[0].thumbnailUrl)
      @set('gravatarName', data.entry[0].displayName)
