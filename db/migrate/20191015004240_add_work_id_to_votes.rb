class AddWorkIdToVotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :work, foreign_key: true
  end
end
