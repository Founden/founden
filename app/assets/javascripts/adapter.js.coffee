Founden.ApplicationAdapter = Ember.RESTAdapter.extend
  # API End-point namespace
  url: 'api/v1'

Ember.Model.reopenClass
  adapter: Founden.ApplicationAdapter.create()
  url: 'api/v1/'
  camelizeKeys: true

# Monkey patch to add support for readOnly attributes
Ember.Model.reopen
  id: Ember.attr(),

  removeReadOnly: (json) ->
    attributes = @constructor.getAttributes()
    attributes.pushObjects(@constructor.getRelationships())
    meta = Ember.meta(@)
    rootKey = @constructor.rootKey
    camelizeKeysFlag = @constructor.camelizeKeys

    attributes.forEach (attribute) ->
      attributeMeta = meta.descs[attribute].meta()
      if attributeMeta.options and attributeMeta.options.readOnly
        attribute = Ember.String.decamelize(attribute) if camelizeKeysFlag
        delete json[rootKey][attribute]
    json

  toJSON: ->
    json = @_super()
    @removeReadOnly(json)

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
