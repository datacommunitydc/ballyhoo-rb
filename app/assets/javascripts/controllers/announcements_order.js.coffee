angular.module('AnnouncementsOrderEditor',[])
  .controller 'AnnouncementsOrderEditor', ($scope, $http, $window) ->
    $scope.meetupId = $window.location.pathname.match(/\/meetups\/(\d+)\/announcement_order\/edit/)[1]

    $scope.announcements = {
      queued: [],
      visible: [],
      archived: []
    }

    $scope.announcements = $http.get("/meetups/#{$scope.meetupId}/announcement_order.json")
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
      alert "TODO"

