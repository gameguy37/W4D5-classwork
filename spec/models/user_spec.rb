# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Testing user validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should allow_value(nil).for(:password)}
  end

  let!(:user) { create(:user) }

  describe "#password=()" do
    # FactoryBot.create(:user)
    
    
    it "should set the password_digest" do
      expect(user.password_digest).to_not be_nil  
    end
  end

  describe "::find_by_credentials" do
    let!(:user2) { User.create(username: 'idk', password: 'test123')}

    it "should return nil if credentials are false" do
      expect(User.find_by_credentials('fakeguy', 'test123')).to be(nil)
      expect(User.find_by_credentials('idk', 'test124')).to be(nil)
    end

    it "should return User if credentials are good" do
      expect(User.find_by_credentials('idk', 'test123')).to eq(user2)
    end

  end

  describe "#is_password?" do
    # let!(:user) { User.create(username: 'idk', password: 'test123')}
    it "should return false is password is bad" do
      expect(user.is_password?('fakepassword')).to be(false)
    end

    it "should return true if password is good" do
      expect(user.is_password?('test123')).to be(true)
    end
  end

  describe "::generate_session_token" do
    it "should return a different session token" do
      token1 = User.generate_session_token
      token2 = User.generate_session_token
      expect(token1).to_not eq(token2)
    end
  end

  describe "#ensure_session_token" do
    # let!(:user) { User.create(username: 'idk', password: 'test123')}
    it "should set session token" do
      expect(user.session_token).to_not be_nil
    end

  end

  describe "#reset_session_token!" do
    # let!(:user) { User.create(username: 'idk', password: 'test123')}
    it "should reset session token" do
      session_token = user.session_token
      expect(user.reset_session_token).to_not eq(session_token)
    end

  end

end