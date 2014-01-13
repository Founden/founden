Founden.Router.map (match) ->
  @resource 'conversations', ->
    @route 'show', {path: '/:conversation_id'}
    @route 'new', {path: '/new'}
  @resource 'invitations', ->
    @route 'show', {path: '/:invitation_id'}
    @route 'new', {path: '/new'}
