class Parent < ActiveRecord::Base
  has_many :parent_students
  has_many :students, through: :parent_students

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :relationship, :student_ids
  validates :name, presence: true
end
