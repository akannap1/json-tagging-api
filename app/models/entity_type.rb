class EntityType < ActiveRecord::Base
  has_many :entity_identifiers, dependent: :destroy
  validates :name, presence: :true, uniqueness: { case_sensitve: false }
  validates :entity_identifiers, presence: true
  validates_associated :entity_identifiers
end
