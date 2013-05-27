class UserCardScore < ActiveRecord::Base
  attr_accessible :card_id, :last_interacted_at, :last_seen_at, :metric_1_count, :metric_2_count, :seen_times
  belongs_to :card
  belongs_to :user
end
