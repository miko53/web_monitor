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

ActiveRecord::Schema.define(version: 20170910110234) do

  create_table "actuators", force: :cascade do |t|
    t.string   "name"
    t.integer  "device_id"
    t.string   "actuator_type"
    t.integer  "order"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "value"
    t.datetime "refreshDateTime"
    t.boolean  "forced"
  end

  add_index "actuators", ["device_id"], name: "index_actuators_on_device_id"

  create_table "actuators_range_commands", id: false, force: :cascade do |t|
    t.integer "range_command_id", null: false
    t.integer "actuator_id",      null: false
  end

  add_index "actuators_range_commands", ["actuator_id"], name: "index_actuators_range_commands_on_actuator_id"
  add_index "actuators_range_commands", ["range_command_id"], name: "index_actuators_range_commands_on_range_command_id"

  create_table "calculated_data", force: :cascade do |t|
    t.float    "value"
    t.datetime "beginPeriod"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "operation_id"
  end

  add_index "calculated_data", ["beginPeriod"], name: "index_calculated_data_on_beginPeriod"
  add_index "calculated_data", ["operation_id"], name: "index_calculated_data_on_operation_id"

  create_table "dash_board_panels", force: :cascade do |t|
    t.integer  "dash_board_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name"
  end

  create_table "dash_boards", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "datasets", force: :cascade do |t|
    t.string   "device_name"
    t.string   "sensor_name"
    t.string   "operation_name"
    t.integer  "graph_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "follow"
  end

  add_index "devices", ["address"], name: "index_devices_on_address", unique: true

  create_table "graphs", force: :cascade do |t|
    t.integer  "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "dataset_id"
    t.string   "title"
  end

  add_index "graphs", ["dataset_id"], name: "index_graphs_on_dataset_id"
  add_index "graphs", ["report_id"], name: "index_graphs_on_report_id"

  create_table "humidity_data", force: :cascade do |t|
    t.integer  "sensor_id"
    t.float    "value"
    t.datetime "dateTime"
  end

  add_index "humidity_data", ["dateTime"], name: "index_humidity_data_on_dateTime"

  create_table "operations", force: :cascade do |t|
    t.integer  "sensor_id"
    t.float    "currentValue"
    t.integer  "period"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "calcul_type"
    t.datetime "endPeriod"
    t.integer  "number_samples"
    t.integer  "period_unit"
    t.string   "name"
  end

  create_table "panel_items", force: :cascade do |t|
    t.integer  "dash_board_panel_id"
    t.string   "sensor_name"
    t.string   "operation_name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "name"
  end

  create_table "pressure_data", force: :cascade do |t|
    t.integer  "sensor_id"
    t.float    "value"
    t.datetime "dateTime"
  end

  add_index "pressure_data", ["dateTime"], name: "index_pressure_data_on_dateTime"

  create_table "range_commands", force: :cascade do |t|
    t.string  "name"
    t.time    "start_time"
    t.time    "stop_time"
    t.integer "start_day"
    t.integer "stop_day"
    t.string  "command"
  end

  create_table "reports", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "dateBegin"
    t.string   "dateEnd"
    t.boolean  "isRangeSet"
    t.integer  "dayRangeFromEnd"
    t.integer  "user_id"
  end

  create_table "sensors", force: :cascade do |t|
    t.integer  "device_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "order"
    t.string   "sensor_type"
    t.string   "name"
  end

  add_index "sensors", ["device_id"], name: "index_sensors_on_device_id"

  create_table "temperature_data", force: :cascade do |t|
    t.integer  "sensor_id"
    t.float    "value"
    t.datetime "dateTime"
  end

  add_index "temperature_data", ["dateTime"], name: "index_temperature_data_on_dateTime"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "user_name"
    t.string   "api_key"
  end

  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true

  create_table "voltage_data", force: :cascade do |t|
    t.integer  "sensor_id"
    t.float    "value"
    t.datetime "dateTime"
  end

  add_index "voltage_data", ["dateTime"], name: "index_voltage_data_on_dateTime"

end
