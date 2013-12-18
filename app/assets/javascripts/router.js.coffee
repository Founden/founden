Founden.Router.map (match) ->
  @resource 'networks', ->
    @route 'show', {path: '/:network_id'}
    @route 'inbox', {path: '/:network_id/inbox'}
    @route 'ongoing', {path: '/:network_id/ongoing'}
    @route 'compose', {path: '/:network_id/compose'}
    @route 'invite', {path: '/:network_id/invite'}
  @resource 'conversations', ->
    @route 'show', {path: '/:conversation_id'}
  @resource 'invitations', ->
    @route 'show', {path: '/:invitation_id'}
