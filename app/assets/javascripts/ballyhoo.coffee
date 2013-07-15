angular.module('ballyhoo', [
  'controllers'
  'services'
  'directives'
  'ui.sortable'
]).config( ['$locationProvider', '$httpProvider', '$routeProvider', ($locationProvider, $httpProvider, $routeProvider) ->
  #$locationProvider.html5Mode(true)
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content')

  #$routeProvider.when '/meetups/:meetupId/announcement_order/edit', 
  #  controller: 'stuff for later'
])
