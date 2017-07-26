class EntityIdentifierTag < ActiveRecord::Base
  belongs_to :entity_identifier
  belongs_to :tag
end
