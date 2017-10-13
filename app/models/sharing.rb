class Sharing < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :note

  # prevent circular dependency
  validates :recipient_id, uniqueness: { scope: :note_id }
  validate :not_creator
  def not_creator
    errors.add(:recipient_id, 'cannot be the creator') if recipient_id == note.try(:user_id)
  end

  enum permission: {
    owner: 'owner',
    reader: 'reader',
    updater: 'updater'
  }

  before_destroy do
    # remove recipient's sharings
    Sharing.where(note_id: note_id, sender_id: recipient_id).destroy_all
  end
end
