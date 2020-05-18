class RemoveTypeFromUnicorn < ActiveRecord::Migration[5.2]
  def change
    remove_column :unicorns, :type
  end
end
