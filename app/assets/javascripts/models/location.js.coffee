Founden.Location = Founden.Attachment.extend
  isLocation: true
  zoom: 12
  size: '640x200'
  sensor: false
  query: null
  mapboxTheme: 'examples.map-9ijuk24y'
  geocoder: null

  longitude: DS.attr('number')
  latitude: DS.attr('number')

  queryChanged: ( ->
    Ember.run.debounce(@, 'search', 200)
  ).observes('query')

  search: ->
    return unless query = @get('query')

    unless geocoder = @get('geocoder')
      geocoder = L.mapbox.geocoder @get('mapboxTheme')
      @set('geocoder', geocoder)

    geocoder.query query, (error, results) =>
      if results.latlng and results.latlng.length > 0
        @set('latitude', results.latlng[0])
        @set('longitude', results.latlng[1])
