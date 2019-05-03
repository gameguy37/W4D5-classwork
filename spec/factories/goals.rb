# == Schema Information
#
# Table name: goals
#
#  id        :bigint           not null, primary key
#  user_id   :integer          not null
#  completed :boolean          default(FALSE)
#  body      :text             not null
#  privacy   :string           not null
#  title     :string           not null
#

FactoryBot.define do
  factory :goal do
    user { create(:user) }
    body { Faker::Lorem.paragraph }
    privacy { Goal::Privacy.sample }
    title { Faker::Lorem.word }
    completed {false}
  end
end
