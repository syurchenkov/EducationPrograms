class EducationalRelationship < ApplicationRecord
  belongs_to :education_program
  belongs_to :educational, polymorphic: true
end
