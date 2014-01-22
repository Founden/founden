Founden.ContactsIndexController = Ember.Controller.extend

  actions:

    removeContact: (contact) ->
      contact.deleteRecord()
      contact.save()
