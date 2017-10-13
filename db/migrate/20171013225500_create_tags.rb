class CreateTags < ActiveRecord::Migration[5.1]
  def up
    create_table :tags do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :tags, :name, unique: true
  end

  def down
    remove_index :tags, :name

    drop_table :tags
  end
end
