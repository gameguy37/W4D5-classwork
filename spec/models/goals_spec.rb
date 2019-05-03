require 'rails_helper'

RSpec.describe Goal, type: :model do
  #has a user id
  #has compeleted column
  #has body
  #private or public 
  #has a title
 
  describe "validations of Goal object" do
    it {should validate_presence_of(:user_id) }
    it {should validate_inclusion_of(:completed).in_array([true, false])} # could be a boolean
    it {should validate_presence_of(:body)}
    it {should validate_presence_of(:title) }
    it {should validate_inclusion_of(:privacy).in_array(Goal::Privacy)}

    it {should belong_to(:user)}
  end



end
