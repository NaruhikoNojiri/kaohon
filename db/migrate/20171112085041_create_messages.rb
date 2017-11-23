class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user, index: true, foreign_key: true
      t.references :conversation, index: true, foreign_key: true
      t.text :content
      t.boolean :read

      t.timestamps null: false
    end
  end
end
