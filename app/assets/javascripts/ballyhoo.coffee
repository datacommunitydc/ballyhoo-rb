angular.module('ballyhoo', [
  'services'
]).controller 'announcementsOrderEditor', ($scope, AnnouncementOrder) ->
    $scope.announcements = {
      queued: [],
      visible: [],
      archived: []
    }

    $scope.announcements = AnnouncementOrder.query({meetup_id: 4})
