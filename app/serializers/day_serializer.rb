class DaySerializer < ActiveModel::Serializer
  attributes :id, :date
  #has_many :metric_scores
  #has_one :user

  self.root = false

  #def pretty_date
    #object.date.strftime("%a #{object.date.day.ordinalize}")
  #end

end
