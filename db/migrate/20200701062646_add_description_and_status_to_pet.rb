class AddDescriptionAndStatusToPet < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :description, :text
    add_column :pets, :status, :string
  end
end
