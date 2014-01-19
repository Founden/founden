# AMS is kinda broken now and will output JSON with null attributes
# instead of empty arrays, this should fix it for a while
Founden.initializer
  name: 'aliases'
  initialize: (container, application)->
    aliasesMap =
      message: ['parentMessage', 'reply']

    # Lets create the aliases now
    for type, aliases of aliasesMap
      typeModel = container.resolve('model:' + type)
      for alias in aliases
        container.register('model:' + alias, typeModel)
