class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :time_zone

  has_many :days
  has_many :metrics
  has_many :user_card_scores, dependent: :destroy
  has_many :card_scores, :foreign_key => 'user_id', :class_name => "UserCardScore"
end
