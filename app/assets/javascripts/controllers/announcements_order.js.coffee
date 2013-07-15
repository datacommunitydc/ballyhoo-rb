angular.module('AnnouncementsOrderEditor',[])
  .controller 'AnnouncementsOrderEditor', ($scope, AnnouncementOrder, $window) ->

    AnnouncementOrder.setMeetupId $window.location.pathname.match(/\/meetups\/(\d+)\/announcement_order\/edit/)[1]

    $scope.announcements = {
      queued: undefined,
      visible: undefined,
      archived: undefined
    }

    $scope.state = { dirty: false }
    $scope.stateClass = ->
      if $scope.state.dirty
        'btn-primary'
      else
        'pristine'

    setChanged = (newVal, oldVal) ->
      unless oldVal is undefined
        $scope.state.dirty = true

    $scope.$watch 'announcements.queued', setChanged, true
    $scope.$watch 'announcements.visible', setChanged, true
    $scope.$watch 'announcements.archived', setChanged, true

    $scope.announcements = AnnouncementOrder.load()
      .success (data) ->
        $scope.announcements = data

    $scope.sortableOptions = 
      axis: 'y'

    $scope.moveRight = (set, ann) ->
      to = if set == 'queued' then 'visible' else 'archived'
      $scope.announcements[set] = _.without($scope.announcements[set], ann)
      $scope.announcements[to].push(ann)

    $scope.moveLeft = (set, ann) ->
      to = if set == 'visible' then 'queued' else 'visible'
      $scope.announcements[set] = _.without($scope.announcements[set], ann)
      $scope.announcements[to].push(ann)

    $scope.makeAllVisible = ->
      for ann in $scope.announcements.queued
        $scope.announcements.visible.push(ann)
      $scope.announcements.queued = []

    $scope.archiveAll = ->
      for ann in $scope.announcements.visible
        $scope.announcements.archived.push(ann)
      $scope.announcements.visible = []

    $scope.save = ->
      AnnouncementOrder.save($scope.announcements)
        .success ->
          $scope.state.dirty = false
