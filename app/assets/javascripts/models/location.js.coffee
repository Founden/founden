Founden.Location = Founden.Attachment.extend
  isLocation: true
  zoom: 12
  size: '640x200'
  sensor: false
  query: null

  longitude: DS.attr('number')
  latitude: DS.attr('number')

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
