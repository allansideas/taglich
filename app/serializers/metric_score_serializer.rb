class MetricScoreSerializer < ActiveModel::Serializer
  attributes :id, :score

  def attributes
    data = super
    data[:metric] = object.metric
    data[:day] = object.day
    data[:last_8] = build_historical
    data
  end

  def build_historical
    @data = []
    days = object.day.user.days.where('date < ? AND date >= ?', object.day.date, object.day.date - 8.days)
    if days
      days.each_with_index do |d, i|
        metric_score = MetricScore.where(day_id: d.id, metric_id: object.metric.id).first
        if metric_score
          @data << {date: pretty_date(d.date), score: metric_score.score}
        end
      end
    else
      @data << {score: "new"}
    end
    @data
  end


  def pretty_date(date)
    date.strftime("%a #{date.day.ordinalize}")
  end
end
