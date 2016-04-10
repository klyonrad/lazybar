# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160410115327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cocktail_recipe_parts", force: :cascade do |t|
    t.integer  "cocktail_recipe_id",                              null: false
    t.integer  "ingredient_category_id",                          null: false
    t.integer  "ingredient_id"
    t.decimal  "amount",                 precision: 15, scale: 9
    t.boolean  "strict"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "cocktail_recipe_parts", ["cocktail_recipe_id"], name: "index_cocktail_recipe_parts_on_cocktail_recipe_id", using: :btree
  add_index "cocktail_recipe_parts", ["ingredient_category_id"], name: "index_cocktail_recipe_parts_on_ingredient_category_id", using: :btree
  add_index "cocktail_recipe_parts", ["ingredient_id"], name: "index_cocktail_recipe_parts_on_ingredient_id", using: :btree

  create_table "cocktail_recipes", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "cocktail_recipes", ["name"], name: "index_cocktail_recipes_on_name", unique: true, using: :btree

  create_table "ingredient_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.integer  "ingredient_category_id"
    t.string   "name",                                                           null: false
    t.decimal  "price_per_cl",           precision: 14, scale: 4,                null: false
    t.boolean  "available",                                       default: true, null: false
    t.string   "comment"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
  end

  add_index "ingredients", ["ingredient_category_id"], name: "index_ingredients_on_ingredient_category_id", using: :btree
  add_index "ingredients", ["name"], name: "index_ingredients_on_name", unique: true, using: :btree

  add_foreign_key "cocktail_recipe_parts", "cocktail_recipes"
  add_foreign_key "cocktail_recipe_parts", "ingredient_categories"
  add_foreign_key "cocktail_recipe_parts", "ingredients"
  add_foreign_key "ingredients", "ingredient_categories"
end
