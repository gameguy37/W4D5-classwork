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

class Goal < ApplicationRecord
    #in case you want restricted to your make believe friends
    Privacy = ['Private', 'Public']
    
    validates :user_id, :body, :title, presence: true
    validates :privacy, inclusion: { in: Privacy}
    validates_inclusion_of :completed, in: [true, false]
    
    after_initialize :ensure_completed_status

    belongs_to :user,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User
        
    private 
    def ensure_completed_status
        self.completed ||= false
    end
end
