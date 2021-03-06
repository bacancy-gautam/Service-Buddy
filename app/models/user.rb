class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum gender: %i[male female other]

  has_one_attached :image, dependent: :destroy
  has_one :provider, dependent: :destroy
  has_many :messages
  has_many :conversations, foreign_key: :sender_id
  has_many :comments, dependent: :destroy
  has_many :favourite_posts, dependent: :destroy
  has_many :provider_details, through: :favourite_posts
  has_many :likes, dependent: :destroy

  before_destroy {
    conversations = Conversation.where("sender_id= ? OR recipient_id= ?", self.id, self.id)
    conversations.destroy_all
  }

  # VALIDATION :
  validates :firstname, :lastname, presence: true
  validate :birth_date_future?
  validates :contact, :presence => { :message => 'is not valid' },
                      :numericality => true,
                      :length => { :minimum => 10, :maximum => 15 }

  def fullname
    "#{firstname.capitalize} #{lastname.capitalize}"
  end

  # private

  def birth_date_future?
    if dob.present?
      if dob > Date.today
        errors.add(:dob, "can't be in the future")
      end
    else
      errors.add(:dob, "can't be blank")
    end  
  end

end
