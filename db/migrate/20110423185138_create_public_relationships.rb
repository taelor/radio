class CreatePublicRelationships < ActiveRecord::Migration
  def self.up
    create_table :public_relationships do |t|
      t.integer :guest_id
      t.integer :publicist_id

      t.timestamps
    end
  end

  def self.down
    drop_table :public_relationships
  end
end
