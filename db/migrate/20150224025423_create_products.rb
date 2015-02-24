class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :hashed_id,    index: true
      t.string  :name,         index: true, null: false
      t.text    :description,  null: false
      t.float   :price,        index: true, null: false
      t.boolean :discontinued, default: false
      t.boolean :deleted,      default: false

      t.timestamps
    end
  end
end
