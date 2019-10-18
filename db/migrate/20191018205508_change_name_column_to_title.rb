class ChangeNameColumnToTitle < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :name, :title
  end
end
