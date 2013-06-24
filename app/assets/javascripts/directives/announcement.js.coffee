angular.module('AnnouncementTag', [])
  .directive 'announcement', ->

    restrict: 'E'
    transclude: false
    scope:
      announcement: "="
      layout: '@'
    templateUrl: "announcements/announcement_tag"
    replace: true

