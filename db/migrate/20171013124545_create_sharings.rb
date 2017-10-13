class CreateSharings < ActiveRecord::Migration[5.1]
  def up
    create_table :sharings do |t|
      t.references :sender
      t.references :recipient
      t.references :note, foreign_key: true
      t.string :permission, null: false, default: :reader
    end

    # Rails 5+ only: add foreign keys
    add_foreign_key :sharings, :users, column: :sender_id, primary_key: :id
    add_foreign_key :sharings, :users, column: :recipient_id, primary_key: :id

    # Don't allow to create multiple sharings
    add_index :sharings, %i[note_id recipient_id], unique: true
  end

  def down
    remove_index :sharings, %i[note_id recipient_id]

    remove_foreign_key :sharings, column: :sender_id
    remove_foreign_key :sharings, column: :recipient_id

    drop_table :sharings
  end
end
