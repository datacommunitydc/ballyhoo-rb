angular.module('AnnouncementOrder',['ngResource'])
  .factory 'AnnouncementOrder', ($http) ->
    ( ->
      meetupId = 0

      setMeetupId: (mid) -> meetupId = mid
      load: ->
        $http.get("/meetups/#{meetupId}/announcement_order.json")

      save: (anns) ->
        # Want to send:
        # announcements:
        #   [
        #     { id: x, status: 'queued', display_order: 2}
        #     { id, y, status: 'visible', display_order: 1}
        #   ]
        data = {announcements: []}
        for status, list of anns
          for ann, i in list
            data.announcements.push
              id: ann.id
              status: status
              display_order: i

        $http.put "/meetups/#{meetupId}/announcement_order.json", data

    )()
