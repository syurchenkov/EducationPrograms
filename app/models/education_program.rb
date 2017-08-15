class EducationProgram < ApplicationRecord
  has_many :educational_relationships
  has_many :users, through: :educational_relationships, source: :educational, source_type: 'User'
  has_many :groups, through: :educational_relationships, source: :educational, source_type: 'Group'


  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 10000 }
end
