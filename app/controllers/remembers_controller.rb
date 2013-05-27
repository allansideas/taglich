class RemembersController < ApplicationController

  def fetch_german_remember
    doc = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }

      json = Jbuilder.encode do |json|
        doc.get('http://www.flashcardexchange.com/flashcards/export/1987588') do |page|
          json.array! page.search('textarea').text.split(/\n/).to_a do |json ,line|
            json.side_1 line.split(/\t/)[0]
            json.side_2 line.split(/\t/)[1]
          end
        end
      end
        #page.search('textarea').text.split(/\n/).each_with_index do |line, i|
          #puts line.split(/\t/)[0]
          #puts line.split(/\t/)[1]
          ##line.split(/\t/).each_with_index do |side, index|
            ##if index == 0
              ##json.side_1 side
            ##else
              ##json.side_2 side
            ##end
          ##end

        #end
      #end
    #end


    render json: json, root: false
  end

  def german_to_builder(doc)
  end
end
