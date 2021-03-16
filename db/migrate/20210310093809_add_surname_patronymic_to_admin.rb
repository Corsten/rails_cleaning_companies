class AddSurnamePatronymicToAdmin < ActiveRecord::Migration[6.0]
  def change
  	add_column :admins, :surname, :string, null: false
  	add_column :admins, :patronymic, :string, null: false
  end
end
