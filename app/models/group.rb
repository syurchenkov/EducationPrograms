class Group < ApplicationRecord
  has_many :user_groups
  has_many :users, through: :user_groups

  has_many :educational_relationships, as: :educational
  has_many :education_programs, through: :educational_relationships
end
