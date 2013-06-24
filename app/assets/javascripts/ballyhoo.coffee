angular.module('ballyhoo', [
  'services'
  'directives'
]).controller 'announcementsOrderEditor', ($scope, $http) ->
    $scope.announcements = {
      queued: [],
      visible: [],
      archived: []
    }

    #$scope.announcements = AnnouncementOrder.query({meetup_id: 4})
    $scope.announcements = $http.get('/meetups/4/announcement_order.json')
      .success (data) ->
        $scope.announcements = data
