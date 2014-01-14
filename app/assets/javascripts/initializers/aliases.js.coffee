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
