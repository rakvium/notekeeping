class Tag < ApplicationRecord
  validates :name,
            format: {
              with: /\A[a-zA-Z0-9_]+\z/,
              message: 'only allows letters and underscores'
            },
            length: { in: 1..255 },
            presence: true,
            uniqueness: { case_sensitive: false }
end
