require 'mechanize'
class CardSet < ActiveRecord::Base
  attr_accessible :name, :url
  has_many :cards
  has_many :user_card_sets
  has_many :users, through: :user_card_sets
  after_save :build_cards

  def build_cards
    doc = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }

    doc.get(self.url) do |page|
      page.search('textarea').text.split(/\n/).each do |line|
        @card = Card.new()
        line.split(/\t/).each do |step|
          @card.card_steps << CardStep.create(content: step)
        end
        self.cards << @card
      end
    end
  end
end
