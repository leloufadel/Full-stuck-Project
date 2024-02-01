class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  has_many :books, foreign_key: :user_id
  has_many :reservations, foreign_key: :user_id

  validates :name, presence: true, length: { minimum: 3 }

  def admin?
    role == 'admin'
  end
end
