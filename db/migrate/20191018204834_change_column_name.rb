class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :works, :published_date, :publication_date
  end
end
