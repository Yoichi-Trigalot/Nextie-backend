class AddNameToUnicorns < ActiveRecord::Migration[5.2]
  def change
    add_column :unicorns, :name, :string
  end
end
