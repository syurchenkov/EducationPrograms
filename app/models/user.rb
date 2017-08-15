class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
  validates :name,  presence: true, length: { maximum: 30 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true 

  has_many :user_groups
  has_many :groups, through: :user_groups

  has_many :educational_relationships, as: :educational
  has_many :education_programs, through: :educational_relationships

  before_save { self.email = email.downcase }
  before_save { self.name  = name.strip }
end
