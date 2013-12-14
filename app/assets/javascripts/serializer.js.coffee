Founden.ApplicationSerializer = DS.ActiveModelSerializer.extend
  # Apparently ember data is ignoring readOnly flag
  serializeAttribute: (record, json, key, attribute) ->
    unless attribute.options.readOnly
      return @_super(record, json, key, attribute)

  # Polymorphic inherited models require a payload with own `typeKey`
  extractArray: (store, type, payload) ->
    if superTypeKey = type.superclass.typeKey
      typeRoot = Ember.String.decamelize(type.typeKey)
      root = @keyForAttribute(superTypeKey)
      partials = payload[Ember.String.pluralize(root)]
      payload[Ember.String.pluralize(typeRoot)] = partials
    @_super store, type, payload
