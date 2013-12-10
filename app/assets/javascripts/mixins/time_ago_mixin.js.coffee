Founden.TimeAgoMixin = Ember.Mixin.create
  ticker: Date.now()
  delay: 10000
  timeAgoProperty: 'createdAt'
  interval: null

  init: ->
    @_super()
    intervalId = setInterval =>
      @set('ticker', Date.now())
    , @get('delay')
    @set('interval', intervalId)

  timeAgo: (->
    @get(@get('timeAgoProperty'))
  ).property('ticker')
