#= require moment

#= require handlebars
#= require ember
#= require ember-model

#= require_self
#= require_tree ./mixins
#= require ./adapter
#= require_tree ./transforms
#= require_tree ./models
#= require_tree ./initializers
# require ./serializer
# require ./store
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./templates
#= require_tree ./routes
#= require ./router

Ember.LOG_VERSION = false

((w, $) ->
  w.Founden ||= Ember.Application.create
    rootElement: '#app'

) window, jQuery
