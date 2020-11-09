class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :impression, null: false
      t.string :author, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
