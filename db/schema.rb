# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_12_160554) do

  create_table "actuators", force: :cascade do |t|
    t.string "name"
    t.integer "device_id"
    t.string "actuator_type"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "value"
    t.datetime "refreshDateTime"
    t.boolean "forced"
    t.index ["device_id"], name: "index_actuators_on_device_id"
  end

  create_table "actuators_range_commands", id: false, force: :cascade do |t|
    t.integer "range_command_id", null: false
    t.integer "actuator_id", null: false
    t.index ["actuator_id"], name: "index_actuators_range_commands_on_actuator_id"
    t.index ["range_command_id"], name: "index_actuators_range_commands_on_range_command_id"
  end

  create_table "calculated_data", force: :cascade do |t|
    t.float "value"
    t.datetime "beginPeriod"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "operation_id"
    t.index ["beginPeriod", "operation_id"], name: "index_calculated_data_on_beginPeriod_and_operation_id", order: { beginPeriod: :desc }
    t.index ["beginPeriod"], name: "index_calculated_data_on_beginPeriod"
    t.index ["operation_id"], name: "index_calculated_data_on_operation_id"
  end

  create_table "dash_board_panels", force: :cascade do |t|
    t.integer "dash_board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "dash_boards", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "datasets", force: :cascade do |t|
    t.string "device_name"
    t.string "sensor_name"
    t.string "operation_name"
    t.integer "graph_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "follow"
    t.index ["address"], name: "index_devices_on_address", unique: true
  end

  create_table "electrical_consumption_data", force: :cascade do |t|
    t.integer "sensor_id"
    t.float "value"
    t.datetime "dateTime"
    t.index ["dateTime"], name: "index_electrical_consumption_data_on_dateTime", order: :desc
  end

  create_table "electrical_power_data", force: :cascade do |t|
    t.integer "sensor_id"
    t.float "value"
    t.datetime "dateTime"
    t.index ["dateTime"], name: "index_electrical_power_data_on_dateTime", order: :desc
  end

  create_table "graphs", force: :cascade do |t|
    t.integer "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dataset_id"
    t.string "title"
    t.index ["dataset_id"], name: "index_graphs_on_dataset_id"
    t.index ["report_id"], name: "index_graphs_on_report_id"
  end

  create_table "humidity_data", force: :cascade do |t|
    t.integer "sensor_id"
    t.float "value"
    t.datetime "dateTime"
    t.index ["dateTime"], name: "index_humidity_data_on_dateTime"
  end

  create_table "operations", force: :cascade do |t|
    t.integer "sensor_id"
    t.float "currentValue"
    t.integer "period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "calcul_type"
    t.datetime "endPeriod"
    t.integer "number_samples"
    t.integer "period_unit"
    t.string "name"
    t.datetime "eventDateTime"
  end

  create_table "panel_items", force: :cascade do |t|
    t.integer "dash_board_panel_id"
    t.string "sensor_name"
    t.string "operation_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "pressure_data", force: :cascade do |t|
    t.integer "sensor_id"
    t.float "value"
    t.datetime "dateTime"
    t.index ["dateTime"], name: "index_pressure_data_on_dateTime"
  end

  create_table "range_commands", force: :cascade do |t|
    t.string "name"
    t.time "start_time"
    t.time "stop_time"
    t.integer "start_day"
    t.integer "stop_day"
    t.string "command"
  end

  create_table "reports", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "dateBegin"
    t.string "dateEnd"
    t.boolean "isRangeSet"
    t.integer "dayRangeFromEnd"
    t.integer "user_id"
  end

  create_table "sensors", force: :cascade do |t|
    t.integer "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.string "sensor_type"
    t.string "name"
    t.index ["device_id"], name: "index_sensors_on_device_id"
  end

  create_table "temperature_data", force: :cascade do |t|
    t.integer "sensor_id"
    t.float "value"
    t.datetime "dateTime"
    t.index ["dateTime"], name: "index_temperature_data_on_dateTime"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_hash"
    t.string "password_salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_name"
    t.string "api_key"
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  create_table "voltage_data", force: :cascade do |t|
    t.integer "sensor_id"
    t.float "value"
    t.datetime "dateTime"
    t.index ["dateTime"], name: "index_voltage_data_on_dateTime"
  end

end
