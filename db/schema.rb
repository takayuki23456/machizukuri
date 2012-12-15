# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 1) do

  create_table "contacts", :force => true do |t|
    t.string   "name",            :null => false
    t.string   "tel",             :null => false
    t.string   "email",           :null => false
    t.string   "contact_kind",    :null => false
    t.string   "contact_content", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "counts", :force => true do |t|
    t.integer  "count",      :default => 0,  :null => false
    t.string   "uu_code",    :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end