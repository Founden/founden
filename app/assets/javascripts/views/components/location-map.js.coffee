Founden.LocationMapComponent = Ember.Component.extend
  classNames: ['location-map']
  mapbox: null
  zoom: 15

  didInsertElement: ->
    element = @$().find('.location-map-canvas')[0]
    mapbox = L.mapbox.map(element, @get('mapboxTheme'))
    mapbox.scrollWheelZoom.disable()
    @set('mapbox', mapbox)

  coordinates: ( ->
    if @get('latitude') and @get('longitude')
      [@get('latitude'), @get('longitude')]
  ).property('latitude', 'longitude')

  centerMap: ( ->
    if coordinates = @get('coordinates')
      @get('mapbox').setView(coordinates, @get('zoom'))
  ).observes('coordinates', 'mapbox')
