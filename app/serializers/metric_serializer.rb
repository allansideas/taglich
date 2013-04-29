class MetricSerializer < ActiveModel::Serializer
  attributes :id, :name, :score_type
  has_many :metric_scores
end
