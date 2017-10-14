class Tag < ApplicationRecord
  validates :name,
            format: {
              with: /\A[a-zA-Z0-9_]+\z/,
              message: 'only allows letters and underscores'
            },
            length: { in: 1..255 },
            presence: true,
            uniqueness: { case_sensitive: false }

  has_many :note_tags
  has_many :notes, through: :note_tags
end
