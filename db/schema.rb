# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110717063642) do

  create_table "client_addrs", :force => true do |t|
    t.string   "title"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_addrs", ["client_id"], :name => "index_client_addrs_on_client_id"
  add_index "client_addrs", ["created_at"], :name => "index_client_addrs_on_created_at"

  create_table "clients", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "phone",      :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
  end

  add_index "employees", ["email"], :name => "index_employees_on_email", :unique => true

  create_table "quote_items", :force => true do |t|
    t.string   "item_num"
    t.string   "description"
    t.integer  "qty"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.string   "notes"
    t.integer  "quote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quote_items", ["quote_id"], :name => "index_quote_items_on_quote_id"

  create_table "quotes", :force => true do |t|
    t.string   "title"
    t.string   "notes",      :default => " "
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quotes", ["client_id"], :name => "index_quotes_on_client_id"
  add_index "quotes", ["created_at"], :name => "index_quotes_on_created_at"

end
