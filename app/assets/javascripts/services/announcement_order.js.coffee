angular.module('AnnouncementOrder',['ngResource'])
  .factory 'AnnouncementOrder', ($resource) ->
    AnnouncementOrder = $resource '/meetups/:meetup_id/announcement_order', {}, {}
