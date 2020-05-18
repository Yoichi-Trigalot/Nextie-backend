class AddDemandOnUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :demand, :boolean, default: false
  end
end
