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

ActiveRecord::Schema.define(version: 20171107124303) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "cocktail_recipe_parts", id: :serial, force: :cascade do |t|
    t.integer "cocktail_recipe_id", null: false
    t.integer "ingredient_category_id", null: false
    t.integer "ingredient_id"
    t.decimal "amount", precision: 15, scale: 9
    t.boolean "strict", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cocktail_recipe_id"], name: "index_cocktail_recipe_parts_on_cocktail_recipe_id"
    t.index ["ingredient_category_id"], name: "index_cocktail_recipe_parts_on_ingredient_category_id"
    t.index ["ingredient_id"], name: "index_cocktail_recipe_parts_on_ingredient_id"
  end

  create_table "cocktail_recipes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cocktail_recipes_on_name", unique: true
  end

  create_table "ingredient_categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", id: :serial, force: :cascade do |t|
    t.integer "ingredient_category_id"
    t.string "name", null: false
    t.decimal "price_per_cl", precision: 14, scale: 4, null: false
    t.boolean "available", default: true, null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_category_id"], name: "index_ingredients_on_ingredient_category_id"
    t.index ["name"], name: "index_ingredients_on_name", unique: true
  end

  create_table "user_cocktail_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "cocktail_recipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cocktail_recipe_id"], name: "index_user_cocktail_likes_on_cocktail_recipe_id"
    t.index ["user_id"], name: "index_user_cocktail_likes_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cocktail_recipe_parts", "cocktail_recipes"
  add_foreign_key "cocktail_recipe_parts", "ingredient_categories"
  add_foreign_key "cocktail_recipe_parts", "ingredients"
  add_foreign_key "ingredients", "ingredient_categories"
  add_foreign_key "user_cocktail_likes", "cocktail_recipes"
  add_foreign_key "user_cocktail_likes", "users"
end
