angular.module('services.user',  [])
.service('UserService', ["$rootScope", "User", ($rootScope, User)->
  user = {}

  User.current((data)->
    user = data
    console.log user
  )

  getUser: ()->
    user
])

