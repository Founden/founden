Founden.ApplicationAdapter = Ember.RESTAdapter.extend
  # API End-point namespace
  url: 'api/v1'

Ember.Model.reopenClass
  adapter: Founden.ApplicationAdapter.create()
  url: 'api/v1/'
  camelizeKeys: true

# It's not idiomatic, but saves time migrating from ember-data
Founden.hasMany = Ember.hasMany
Ember.hasMany = (type, options) ->
  typeClass = 'Founden.' + Ember.String.classify(type)
  Founden.hasMany(typeClass, options)
Founden.belongsTo = Ember.belongsTo
Ember.belongsTo = (type, options) ->
  typeClass = 'Founden.' + Ember.String.classify(type)
  Founden.belongsTo(typeClass, options)
