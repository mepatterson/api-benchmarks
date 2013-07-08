class CreateItems < ActiveRecord::Migration
  def up
    return if ActiveRecord::Base.connection.table_exists? 'items'
    create_table :items do |t|
      t.string :name
      t.string :uuid, unique: true
      t.string :hash_code
      t.text :description
      t.timestamps
    end

    add_index :items, :uuid
    # Item.create_translation_table!({ name: :string, description: :text })
  end

  def down
    return unless ActiveRecord::Base.connection.table_exists? 'items'
    drop_table :items
    # Item.drop_translation_table!
  end
end
