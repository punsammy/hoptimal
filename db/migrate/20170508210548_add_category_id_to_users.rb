class AddCategoryIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :category_id, :integer
    remove_column :users, :preference, :string
  end
end
