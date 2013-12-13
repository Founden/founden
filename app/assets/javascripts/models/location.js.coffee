Founden.Location = Founden.Attachment.extend
  isLocation: true
  zoom: 12
  size: '640x200'
  sensor: false
  query: null

  longitude: DS.attr('number')
  latitude: DS.attr('number')

  params: ( ->
    center = [@get('latitude'), @get('longitude')].join(',')
    $.param
      center: center
      zoom: @get('zoom')
      size: @get('size')
      sensor: @get('sensor')
  ).property('latitude', 'longitude')

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
          @set('latitude', response[0].lat)
          @set('longitude', response[0].lon)
