class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :buffet
  enum role: {client:0, buffet_owner:1}
  has_many :orders

  validates :role, presence: true
  validates :name, :individual_registration, presence: true, if: :client?
  validates :individual_registration, uniqueness: true, unless: Proc.new { |user| user.role == 'buffet_owner' }
  validates :individual_registration, cpf: { message: 'CPF inválido'}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
