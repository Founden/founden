Founden.Location = Founden.Attachment.extend
  isLocation: true
  zoom: 12
  size: '640x200'
  sensor: false
  query: null

  lon: DS.attr('number')
  lat: DS.attr('number')

  params: ( ->
    center = [@get('lat'), @get('lon')].join(',')
    $.param
      center: center
      zoom: @get('zoom')
      size: @get('size')
      sensor: @get('sensor')
  ).property('lat', 'lon')

  previewUrl: ( ->
    '//maps.googleapis.com/maps/api/staticmap?%@'.fmt(@get('params'))
  ).property('params')

  queryChanged: ( ->
    Ember.run.debounce(@, 'search', 200)
  ).observes('query')

  search: ->
    $.ajax
      url: 'http://nominatim.openstreetmap.org/search'
      dataType: 'jsonp'
      jsonp: 'json_callback'
      data:
        q: @get('query')
        format: 'json'
      success: (response) =>
        if response.length > 0
          @set('lat', response[0].lat)
          @set('lon', response[0].lon)
