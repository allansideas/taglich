class UserCardScore < ActiveRecord::Base
  attr_accessible :card_id, :user_id, 
    :last_interacted_at, :last_seen_at, 
    :metric_1_count, :metric_2_count, :seen_times
  belongs_to :card
  belongs_to :user

  after_initialize :set_defaults

  private
  def set_defaults
    self.last_seen_at ||= Time.zone.now
    self.last_interacted_at ||= Time.zone.now
    self.metric_1_count ||= 0
    self.metric_2_count ||= 0
    self.seen_times ||= 0
  end
end
