class MetricScoreSerializer < ActiveModel::Serializer
  attributes :id, :score

  def attributes
    data = super
    data[:metric] = object.metric
    data[:day] = object.day
    data[:streak] = build_streak
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

  def build_streak
    if object.score > 0
      zero_date = object.day.user.days.joins(:metric_scores).where('days.date <= ? AND metric_scores.score = 0 AND metric_scores.metric_id = ?', object.day.date, object.metric.id).order('days.date desc').limit(1).first
      if zero_date
        days = (object.day.date - zero_date).to_i
      else
        days = 0
      end
    else
      zero_date = object.day.user.days.joins(:metric_scores).where('days.date <= ? AND metric_scores.score = 0 AND metric_scores.metric_id = ?', object.day.date - 1.days, object.metric.id).order('days.date desc').limit(1).first.date
      if zero_date
        days = ((object.day.date - 1.days) - zero_date).to_i
      else
        days = 0
      end
    end
    if days < 0 
      days = 0
    end
    days
  end

  def pretty_date(date)
    date.strftime("%a #{date.day.ordinalize}")
  end
end
