angular.module('AnnouncementsIndex', [])
  .controller 'AnnouncementsIndex', ($scope, AnnouncementOrder, $window, $timeout) ->

    AnnouncementOrder.setMeetupId $window.location.pathname.match(/\/meetups\/(\d+)\//)[1]

    $scope.announcements = []

    # TODO this is very rough. A better idea for polling would be to
    # receive a feed of changes and apply them to the data in scope.
    # That way you can remove, reorder, or change elemeents with less
    # flicker to the user.
    fetchAnnouncements = ->
      AnnouncementOrder.load()
        .success (data) ->
          $scope.announcements = data.visible

    $scope.shouldPoll = -> true

    sco = $scope
    tick = ->
      if sco.shouldPoll()
        fetchAnnouncements()
        $timeout(tick, 5000)
      else
        $timeout(tick, 5000)

    # Need to defer initial execution until after any settings directives have
    # had time to parse
    $timeout(tick, 1)
    
