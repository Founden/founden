Founden.NetworksComposeController = Ember.Controller.extend

  actions:

    create: ->
      conversation = @get('content')

      @store.push 'conversation',
        id: conversation.get('id')
        title: conversation.get('title')
        user: @get('currentUser')
        createdAt: new Date().toString()
        isUnread: true

      @get('network.ongoing').pushObject(conversation)

      @transitionToRoute('conversations.show', conversation)
