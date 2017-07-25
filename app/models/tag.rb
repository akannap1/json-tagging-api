class Tag < ActiveRecord::Base
  has_many :entity_identifier_tags
  has_many :entity_identifiers, through: :entity_identifier_tags
end
