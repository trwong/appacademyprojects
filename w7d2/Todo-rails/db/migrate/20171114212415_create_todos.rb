class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos do |t|
      t.string :title, presence: true
      t.string :body, presence: true
      t.boolean :done

      t.timestamps
    end
  end
end
