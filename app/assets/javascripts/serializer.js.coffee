Founden.ApplicationSerializer = DS.ActiveModelSerializer.extend
  extractArray: (store, type, payload) ->
    type.typeKey = type.superclass.typeKey || type.typeKey
    @_super(store, type, payload)

  # Apparently ember data is ignoring readOnly flag
  serializeAttribute: (record, json, key, attribute) ->
    unless attribute.options.readOnly
      return @_super(record, json, key, attribute)
