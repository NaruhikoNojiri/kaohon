class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id",dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id",class_name: "Relationship", dependent: :destroy
  has_many :followed_users, through: :relationships, source: "followed", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: "follower", dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :conversations, dependent: :destroy

end
