class DaySerializer < ActiveModel::Serializer
  attributes :id, :date, :pretty_date
  has_many :metric_scores

  def pretty_date
    object.date.strftime("%a #{object.date.day.ordinalize}")
  end
end
