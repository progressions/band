# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 57) do

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by", :limit => 11
  end

  create_table "colors", :force => true do |t|
    t.string   "body"
    t.string   "heading"
    t.string   "news_heading"
    t.string   "link"
    t.string   "link_visited"
    t.string   "link_hover"
    t.string   "utility"
    t.string   "main_bg"
    t.string   "sidebar_bg"
    t.string   "module_bg"
    t.string   "module_heading"
    t.string   "module_heading_bg"
    t.string   "module_heading_bg_hover"
    t.string   "footer"
    t.string   "footer_link"
    t.string   "footer_bg"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "setting_id",              :limit => 11
    t.string   "title"
    t.string   "module_heading_hover"
    t.integer  "created_by",              :limit => 11
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "created_by", :limit => 11
    t.integer  "blog_id",    :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "email"
    t.string   "website"
  end

  create_table "entries", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "created_by", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fans", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.integer  "zipcode",       :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
    t.string   "crypted_email"
    t.string   "city"
    t.string   "state"
  end

  create_table "lyrics", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "composer"
    t.integer  "created_by", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mails", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "sent_at"
    t.integer  "created_by", :limit => 11
  end

  create_table "members", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "instruments"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                    :default => true
    t.integer  "position",    :limit => 11
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "body"
    t.boolean  "active",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promos", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "setting_id", :limit => 11
  end

  create_table "settings", :force => true do |t|
    t.string   "site_name"
    t.string   "artist_name"
    t.text     "artist_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_blog",                         :default => true
    t.boolean  "show_news",                         :default => true
    t.boolean  "show_music",                        :default => true
    t.boolean  "show_videos",                       :default => true
    t.boolean  "show_shows",                        :default => true
    t.boolean  "show_fans",                         :default => true
    t.integer  "promo_id",            :limit => 11
    t.string   "email"
    t.string   "admin_email"
    t.string   "url"
    t.string   "mail_tag"
    t.string   "youtube_profile"
    t.string   "featured_playlist"
    t.string   "latest_playlist"
    t.boolean  "show_featured_video",               :default => true
    t.boolean  "show_lyrics",                       :default => true
    t.boolean  "show_promo",                        :default => true
    t.text     "header"
    t.text     "footer"
    t.string   "songs_host"
    t.text     "on_the_web"
    t.integer  "color_id",            :limit => 11
  end

  create_table "shows", :force => true do |t|
    t.string   "title"
    t.datetime "date"
    t.time     "time"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode",    :limit => 11
    t.integer  "created_by", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
    t.string   "cover"
    t.integer  "venue_id",   :limit => 11
    t.time     "end_time"
  end

  create_table "songs", :force => true do |t|
    t.integer  "length",     :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "body"
    t.string   "filename"
    t.integer  "setting_id", :limit => 11
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "blog_id",    :limit => 11
    t.string   "email"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id",        :limit => 11
    t.integer  "taggable_id",   :limit => 11
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
  end

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode",     :limit => 11
    t.string   "website"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "web_profiles", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "image"
    t.integer  "setting_id", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
