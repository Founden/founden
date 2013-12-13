Founden.ApplicationAdapter = DS.ActiveModelAdapter.extend
  # API End-point namespace
  namespace: 'api/v1'
  defaultSerializer: 'application'

  # Make sure we send requests to parent type API endpoint
  pathForType: (type) ->
    decamelized = Ember.String.decamelize(type)
    if decamelized in ['avatar', 'link', 'location', 'task_list', 'upload']
      decamelized = 'attachment'
    Ember.String.pluralize(decamelized)
