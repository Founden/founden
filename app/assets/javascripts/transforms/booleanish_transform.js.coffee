Founden.BooleanishTransform =
  serialize: (value) ->
    !!value

  deserialize: (value) ->
    !!value

Ember.Model.dataTypes['booleanish'] = Founden.BooleanishTransform
