class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :notes
  has_many :received_sharings, class_name: 'Sharing', foreign_key: 'recipient_id'
  has_many :received_notes, through: :received_sharings, source: :note
end
