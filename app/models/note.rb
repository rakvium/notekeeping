class Note < ApplicationRecord
  belongs_to :user
  has_many :sharings, dependent: :destroy
  has_many :users, through: :sharings, source: 'recipient'
  has_many :note_tags
  has_many :tags, through: :note_tags
end
