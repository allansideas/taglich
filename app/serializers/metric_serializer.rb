class MetricSerializer < ActiveModel::Serializer
  attributes :id, :name, :sort_order, :score_type
end
