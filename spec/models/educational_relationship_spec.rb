require 'rails_helper'

RSpec.describe EducationalRelationship, type: :model do
  it { should belong_to :education_program }
  it { should belong_to :educational}
end
