Founden.Router.map (match) ->
  @resource 'networks', ->
    @route 'show', {path: '/:id'}
    @route 'inbox', {path: '/:id/inbox'}
    @route 'ongoing', {path: '/:id/ongoing'}
    @route 'compose', {path: '/:id/compose'}
  @resource 'conversations', ->
    @route 'show', {path: '/:id'}
