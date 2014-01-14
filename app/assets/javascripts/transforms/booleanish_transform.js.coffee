Founden.BooleanishTransform = DS.Transform.extend
  serialize: (value) ->
    !!value

  deserialize: (value) ->
    !!value
