class Card < ActiveRecord::Base
  attr_accessible :card_set_id
  belongs_to :card_set

  after_initialize :set_defaults

  private
  def set_defaults
    self.last_seen_at ||= Time.zone.now
    self.last_interacted_at ||= Time.zone.now
    self.correct_count ||= 0
    self.incorrect_count ||= 0
    self.seen_times ||= 0
  end
end

