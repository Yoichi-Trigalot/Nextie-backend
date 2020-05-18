class AddUnicornTypetoUnicorns < ActiveRecord::Migration[5.2]
  def change
    add_column :unicorns, :unicorn_type, :string
  end
end
