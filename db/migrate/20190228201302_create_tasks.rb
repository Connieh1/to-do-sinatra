class CreateTasks < ActiveRecord::Migration
  def change
    create_table  :task do |t|
      t.string  :name
      t.string  :description
      t.date    :deadline
    end
  end
end
