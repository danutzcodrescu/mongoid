class RaceRef
  include Mongoid::Document
  field :n, as: :name, type: String
  field :date, type: Date
  
  embedded_in :entrant
  belongs_to :race, :foreign_key => :_id
  
  delegate :name, :name=, to: :race, prefix: "race"
  delegate :date, :date=, to: :race, prefix: "race"
  
  
end
