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

# Monkey patch to add support for polymorphic embedded relationships
Ember.EmbeddedHasManyArray.reopen
  materializePolymorphicRecord: (idx) ->
    content = @get('content')
    reference = content.objectAt(idx)

    if reference.record
      return reference.record
    else
      klass = Founden[Ember.String.classify(reference.data.type)]
      record = klass.find(reference.id)
      return record

  materializeRecord: (idx) ->
    if @get('embedded') == 'polymorphic'
      @materializePolymorphicRecord(idx)
    else
      @_super(idx)
