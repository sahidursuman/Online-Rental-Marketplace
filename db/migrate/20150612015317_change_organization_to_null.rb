class ChangeOrganizationToNull < ActiveRecord::Migration
  def change
  	 change_column_null(:users, :organization, true)
  end
end
