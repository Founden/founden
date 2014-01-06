Founden.Link = Founden.Attachment.extend
  isLink: true
  linkType: null
  description: null
  previewUrl: null
  html: null
  authorName: null
  url: Ember.attr()
  endpoint: 'http://api.embed.ly/1/oembed?&callback=?&url='

  didLoad: ->
    @search()

  urlChanged: ( ->
    Ember.run.debounce(@, 'search', 200)
  ).observes('url')

  search: ->
    endpoint = @get('endpoint')
    url = @get('url')
    if url and url.match('https?://(.*[^/])') and url.length > 11
      $.getJSON endpoint + url, (embed) =>
        if embed
          @set('linkType', embed.type)
          @set('title', embed.title)
          @set('description', embed.description)
          @set('previewUrl', embed.thumbnail_url)
          @set('authorName', embed.author_name)
          @set('html', embed.html)

Founden.Link.rootKey = 'link'
