require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ build(:user) }

  it { should have_many :groups }

  context 'validations' do 
    subject { build(:user) }
    
    it { should validate_presence_of :name }
    it { should validate_length_of(:name).is_at_most(30) }
    it { should validate_presence_of :email }
    it { should validate_length_of(:email).is_at_most(255) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should have_secure_password }
    it { should validate_length_of(:password).is_at_least(6)}
  end

  it "is not valid with invalid email format" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                   foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).not_to be_valid
    end      
  end

  it "is valid with valid email format" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid
    end
  end

  context 'when email in mixed case' do 
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }
    let(:user_email){ create(:user, email: mixed_case_email) }

    it "save email in lower-case" do
      expect(user_email.reload.email).to be == mixed_case_email.downcase
    end
  end

  context 'when name with whitespaces' do 
    let(:name) { 'Jon Snow' }
    let(:name_with_whitespaces) { '  ' + name + '    ' }
    let(:user_name) { create(:user, name: name_with_whitespaces) }

    it 'save name without heading and tailing whitespaces' do 
      expect(user_name.reload.name).to be == name
    end
  end

end
