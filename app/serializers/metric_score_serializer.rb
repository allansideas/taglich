class MetricScoreSerializer < ActiveModel::Serializer
  attributes :id, :score

  def attributes
    data = super
    data[:metric] = object.metric
    data[:day] = object.day
    data
  end
end
