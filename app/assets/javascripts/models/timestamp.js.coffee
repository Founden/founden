Founden.Timestamp = Founden.Attachment.extend
  isTimestamp: true
  timestamp: DS.attr('string')

  rawValue: null

  timestampString: ( ->
    timestamp = @get('timestamp')
    if timestamp
      timestamp.toString()
  ).property('timestamp', 'ticker')

  rawValueChanged: ( ->
    date = Date.parse(@get('rawValue'))
    if date
      @set('timestamp', new Date(date))
  ).observes('rawValue')
