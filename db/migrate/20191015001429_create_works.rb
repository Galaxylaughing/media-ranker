class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :category
      t.string :name
      t.string :creator
      t.string :description
      t.date :published_date
      
      t.timestamps
    end
  end
end
