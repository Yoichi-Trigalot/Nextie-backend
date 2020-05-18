class CreateUnicorns < ActiveRecord::Migration[5.2]
  def change
    create_table :unicorns do |t|
      t.string :sex
      t.string :type
      t.string :color
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
