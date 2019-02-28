class CreateUsers < ActiveRecord::Migration
  def change
    create_table  :users do |t|
      t.string  :name
      t.string  :task
    end
  end
end
