class DaySerializer < ActiveModel::Serializer
  attributes :id, :date, :pretty_date, :first_day_created
  has_many :metric_scores
  has_one :user

  def pretty_date
    object.date.strftime("%a #{object.date.day.ordinalize}")
  end

  def first_day_created
    object.user.days.first.date == object.date
  end
end
