# need to require this stuff so we can play with AR models in the migration
require 'goliath/goliath'
require 'goliath/runner'
require 'goliath/rack'
# require 'globalize3'
Dir["./app/models/*.rb"].each { |f| require f }

class CreateItems < ActiveRecord::Migration
  def up
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
    drop_table :items
    # Item.drop_translation_table!
  end
end
