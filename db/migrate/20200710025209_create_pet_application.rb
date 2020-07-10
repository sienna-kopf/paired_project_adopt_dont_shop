class CreatePetApplication < ActiveRecord::Migration[5.1]
  def change
    create_table :pet_applications do |t|
      t.references :pet, foreign_key: true
      t.references :applicant, foreign_key: true

      t.timestamps
    end
  end
end
