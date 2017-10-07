class AddUserToTask < ActiveRecord::Migration[5.0]
  def change
    # add_column :tasks, :user, :reference
    add_reference :tasks, :user, foreign_key: true
  end
end
class AddUserToTask < ActiveRecord::Migration[5.0]
  def change
    # add_column :tasks, :user, :reference
    add_reference :tasks, :user, foreign_key: true
  end
end
