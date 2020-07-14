class AddApprovalStatusToPetApplication < ActiveRecord::Migration[5.1]
  def change
    add_column :pet_applications, :approval_status , :integer, default: 0
  end
end
