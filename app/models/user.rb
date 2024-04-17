class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: {client:0, buffet_owner:1}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
