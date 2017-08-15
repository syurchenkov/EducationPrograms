require 'rails_helper'

RSpec.describe EducationProgram, type: :model do
  it { should have_many(:users).through(:educational_relationships).source(:educational) }
  it { should have_many(:groups).through(:educational_relationships).source(:educational) }
  it { should have_many :educational_relationships }

  context 'validations' do 
    it { should validate_presence_of :title }
    it { should validate_length_of(:title).is_at_most(255) }
    it { should validate_presence_of :content }
    it { should validate_length_of(:content).is_at_most(10000) }
  end
end
