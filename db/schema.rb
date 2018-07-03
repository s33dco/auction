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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_06_24_090345) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bids", force: :cascade do |t|
    t.integer "buyer_id"
    t.integer "lot_id"
    t.decimal "bidvalue", precision: 7, scale: 2
    t.decimal "decimal", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_bids_on_buyer_id"
    t.index ["lot_id"], name: "index_bids_on_lot_id"
  end

  create_table "buyers", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "phone"
    t.string "email"
    t.decimal "commrate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "buyercode"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "houses", force: :cascade do |t|
    t.string "name"
    t.string "address1"
    t.string "address2"
    t.string "address3"
    t.string "postcode"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lots", force: :cascade do |t|
    t.string "manufacturer"
    t.string "model"
    t.string "description"
    t.integer "lotnumber"
    t.decimal "sellingprice", precision: 7, scale: 2
    t.decimal "decimal", precision: 7, scale: 2
    t.decimal "reserve", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sale_id"
    t.integer "seller_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_lots_on_category_id"
    t.index ["sale_id"], name: "index_lots_on_sale_id"
    t.index ["seller_id"], name: "index_lots_on_seller_id"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "house_id"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: false
    t.index ["house_id"], name: "index_sales_on_house_id"
  end

  create_table "sellers", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "phone"
    t.decimal "commrate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sellercode"
  end

end
