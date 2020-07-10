class CreateApplicants < ActiveRecord::Migration[5.1]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :zip
      t.string :state
      t.string :phonenumber
      t.text :description

      t.timestamps
    end
  end
end
