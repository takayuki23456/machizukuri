class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name, :null => false
      t.string :tel, :null => false
      t.string :email, :null => false
      t.string :contact_kind, :null => false
      t.string :contact_content, :null => false
      t.timestamps
    end
    create_table :counts do |t|
      t.integer :count ,:null => false, :default => 0
      t.string :uu_code, :null => false , :default => ""
      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
    drop_table :counts
  end
end
