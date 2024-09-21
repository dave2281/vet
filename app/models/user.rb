class User < ApplicationRecord
  has_many :comments
  has_many :questions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    role == 'admin'
  end

  def member?
    role == 'member'
  end

  def doctor?
    role == 'doctor'
  end
end
