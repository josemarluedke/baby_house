class Parent < ActiveRecord::Base
  has_many :parentages
  has_many :students, through: :parentages

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :relationship, :student_ids
  validates :name, presence: true

  def admin?
  	false
  end

  def before_import_save(row, map)
    self.password = "password"
    self.password_confirmation = "password"
  end
end
