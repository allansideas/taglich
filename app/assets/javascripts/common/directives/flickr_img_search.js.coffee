angular.module('services.flickr_image_search', [])
.service("FlickrImageSearchService", ["$q", "$http", ($q, $http)->
  console.log ("**Service - FlickrImageSearch**") 

  getPhoto: (term)->
    deferred = $q.defer()
    api_key = '17fc4dfdb6d8f5add38584b0bd3d8460'
    url     = 'http://api.flickr.com/services/rest/'
    
    params =
      method: 'flickr.photos.search'
      api_key: api_key
      text: term
      per_page: 5
      format: 'json'
      jsoncallback: 'JSON_CALLBACK'

    $http.jsonp(url, params: params).success (data, status, headers, config) ->
      photos = _.map data.photos.photo, (photo) ->
        title: photo.title
        thumb_src: "http://farm#{photo.farm}.staticflickr.com/#{photo.server}/#{photo.id}_#{photo.secret}_s.jpg"
        src: "http://farm#{photo.farm}.staticflickr.com/#{photo.server}/#{photo.id}_#{photo.secret}_-.jpg"

      deferred.resolve [photos]

    deferred.promise

    #window.single_photo_from_tag = (response) ->
      #p = response.photos.photo[0]
      #src = "http://farm#{p.farm}.staticflickr.com/#{p.server}/#{p.id}_#{p.secret}_m.jpg"
      #console.log scope
      #scope.src = src
      #element.prepend("<img src='#{scope.src}' />")

    #term = "advertising"
    #$http.jsonp(
      #"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=17fc4dfdb6d8f5add38584b0bd3d8460&tags="+term+"&per_page=3&format=json&&jsoncallback=single_photo_from_tag"
    #)
])
