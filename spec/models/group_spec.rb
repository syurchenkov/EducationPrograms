require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should have_many :users }
  it { should have_many :educational_relationships }
  it { should have_many(:education_programs).through(:educational_relationships)  }
end
