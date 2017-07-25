class EntityIdentifier < ActiveRecord::Base
  belongs_to :entity_type
  has_many :entity_identifier_tag, dependent: :destroy
  has_many :tags, through: :entity_identifier_tag, dependent: :destroy
  validates :entity_id, presence: true, uniqueness: { case_sensitve: false }
  validates :tags, presence: true
end
