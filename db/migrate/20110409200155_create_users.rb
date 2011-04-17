class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :bio
      t.string :land_line_phone
      t.string :cell_phone

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
