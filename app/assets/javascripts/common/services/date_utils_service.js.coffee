angular.module('services.date_utils',  [])
.factory('DateUtilsService', ()->
  normalizeDate: (date)->
    date.replace(/\b(\d{1})\b/g, '0$1')

  dateToUrl: (date)->
    date.getFullYear() + "-" + @normalizeDate((1 + date.getMonth()).toString()) + "-" + @normalizeDate(date.getDate().toString()) 

  dateFromUrl: (date_string)->
    #Y/M/D -> [0] = Y, [1] = M, [2] = D
    dateArry = date_string.split("-").splice(0,3)
    jsDate = new Date(dateArry[0], dateArry[1] - 1, dateArry[2])
    jsDate

  getNextDay: (date_string)->
    date = @dateFromUrl(date_string)
    next_day = new Date(date.setDate(date.getDate() + 1))
    next_day = @dateToUrl(next_day)
    next_day

  getPrevDay: (date_string)->
    date = @dateFromUrl(date_string)
    next_day = new Date(date.setDate(date.getDate() - 1))
    next_day = @dateToUrl(next_day)
    next_day
)

