Founden.Router.map (match) ->
  @resource 'conversations', ->
    @route 'show', {path: '/:conversation_id'}
  @resource 'invitations', ->
    @route 'show', {path: '/:invitation_id'}
