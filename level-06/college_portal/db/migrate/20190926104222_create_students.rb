class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.integer :roll_no
      t.integer :department_id
      t.integer :section_id

      t.timestamps
    end
  end
end
