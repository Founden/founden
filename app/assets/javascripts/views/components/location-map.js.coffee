Founden.LocationMapComponent = Ember.Component.extend
  classNames: ['location-map']
  mapbox: null
  mapboxTheme: 'examples.map-9ijuk24y'
  zoom: 12

  didInsertElement: ->
    element = @$().find('.location-map-canvas')[0]
    @set('mapbox', L.mapbox.map(element, @get('mapboxTheme')))
    @get('mapbox').scrollWheelZoom.disable()

  centerMap: ( ->
    coordinates = [@get('latitude'), @get('longitude')]
    @get('mapbox').setView(coordinates, @get('zoom'))
  ).observes('latitude', 'longitude')
