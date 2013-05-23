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
    past_scores = MetricScore.includes(:day, :metric).where("days.user_id = ? AND metric_scores.metric_id = ?", object.day.user.id, object.metric.id).order('days.date DESC').offset(1).limit(8).reverse!
    if past_scores
      past_scores.each do |ps|
        @data << {date: pretty_date(ps.day.date), score: ps.score}
      end
    end
    @data
  end

  def build_streak
    if object.score > 0
      zero_date = object.day.user.days.includes(:metric_scores).where('days.date <= ? AND metric_scores.score = 0 AND metric_scores.metric_id = ?', object.day.date, object.metric.id).order('days.date desc').limit(1).first
      if zero_date
        days = (object.day.date - zero_date.date).to_i
      else
        days = 0
      end
    else
      zero_date = object.day.user.days.includes(:metric_scores).where('days.date <= ? AND metric_scores.score = 0 AND metric_scores.metric_id = ?', object.day.date - 1.days, object.metric.id).order('days.date desc').limit(1).first
      if zero_date
        days = ((object.day.date - 1.days) - zero_date.date).to_i
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
