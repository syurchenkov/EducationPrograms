class EducationProgram < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 10000 }
end
