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

ActiveRecord::Schema[7.2].define(version: 2025_08_24_210900) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bill_of_ladings", force: :cascade do |t|
    t.bigint "upload_id"
    t.datetime "upload_date"
    t.string "number", limit: 9, null: false
    t.bigint "customer_id"
    t.string "consignee_code", limit: 20
    t.string "consignee_name", limit: 60
    t.string "notified_code", limit: 20
    t.string "notified_name", limit: 60
    t.string "vessel_name", limit: 30
    t.string "vessel_voyage", limit: 10
    t.datetime "arrival_date", default: "1970-01-01 00:00:00"
    t.integer "freetime", limit: 2
    t.integer "nbre_20pieds_sec", limit: 2, default: 0
    t.integer "nbre_40pieds_sec", limit: 2, default: 0
    t.integer "nbre_20pieds_frigo", limit: 2, default: 0
    t.integer "nbre_40pieds_frigo", limit: 2, default: 0
    t.integer "nbre_20pieds_special", limit: 2, default: 0
    t.integer "nbre_40pieds_special", limit: 2, default: 0
    t.string "reef", limit: 1, default: ""
    t.string "type_depotage", limit: 30
    t.datetime "date_validite"
    t.string "statut", limit: 30
    t.boolean "exempte", default: false, null: false
    t.boolean "blocked_for_refund", default: false, null: false
    t.string "reference", limit: 60
    t.text "comment"
    t.boolean "valide"
    t.string "released_statut", limit: 20
    t.text "released_comment"
    t.string "operator", limit: 20
    t.string "atp", limit: 30
    t.boolean "consignee_caution", default: false, null: false
    t.string "service_contract", limit: 200
    t.string "bank_account", limit: 30
    t.string "bank_name", limit: 30
    t.string "emails", limit: 60
    t.string "telephone", limit: 20
    t.string "place_receipt", limit: 60
    t.string "place_delivery", limit: 60
    t.string "port_loading", limit: 60
    t.string "port_discharge", limit: 60
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arrival_date"], name: "index_bill_of_ladings_on_arrival_date"
    t.index ["consignee_code"], name: "index_bill_of_ladings_on_consignee_code"
    t.index ["consignee_name"], name: "index_bill_of_ladings_on_consignee_name"
    t.index ["customer_id"], name: "index_bill_of_ladings_on_customer_id"
    t.index ["number"], name: "index_bill_of_ladings_on_number", unique: true
    t.index ["reef"], name: "index_bill_of_ladings_on_reef"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", limit: 60, null: false
    t.string "status", limit: 20
    t.string "customer_code", limit: 20
    t.string "group_name", limit: 150, null: false
    t.boolean "pay_deposit", default: false, null: false
    t.integer "freetime_frigo", limit: 2
    t.integer "freetime_sec", limit: 2
    t.boolean "prioritaire", default: false
    t.bigint "salesrepid"
    t.bigint "financerepid"
    t.bigint "cservrepid"
    t.datetime "date_validite"
    t.string "operator", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.string "reference", limit: 10, null: false
    t.string "bill_of_lading_number", limit: 9, null: false
    t.string "customer_code", limit: 20, null: false
    t.string "customer_name", limit: 60, null: false
    t.decimal "invoice_amount", precision: 12, null: false
    t.decimal "original_amount", precision: 12, scale: 2
    t.string "currency", limit: 6, default: "USD"
    t.string "status", limit: 10, default: "init", null: false
    t.datetime "invoice_date", null: false
    t.bigint "customer_id", null: false
    t.string "create_type_utilisateur", limit: 20
    t.bigint "customer_id_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "due_date"
    t.index ["reference"], name: "index_invoices_on_reference", unique: true
  end

  create_table "refund_requests", force: :cascade do |t|
    t.string "bill_of_lading_number", limit: 9, null: false
    t.string "requested_amount", limit: 15
    t.string "refund_amount", limit: 15
    t.string "deduction", limit: 15
    t.string "status", limit: 10, default: "PENDING"
    t.bigint "id_transitaire", null: false
    t.bigint "id_transitaire_maison"
    t.boolean "transitaire_notifie"
    t.boolean "maison_notifie"
    t.boolean "banque_notifie"
    t.datetime "date_demande"
    t.datetime "date_refund_traite"
    t.string "type_paiement", limit: 10
    t.string "pret", limit: 10
    t.string "soumis", limit: 10
    t.string "consignee_code", limit: 14
    t.string "refund_party_name", limit: 200
    t.string "beneficiaire", limit: 20
    t.string "deposit_amount", limit: 15
    t.string "reason_for_refund", limit: 200
    t.string "remarks", limit: 250
    t.string "co_code", limit: 20
    t.text "zm_doc_no"
    t.string "gl_posting_doc", limit: 15
    t.string "clearing_doc", limit: 15
    t.string "email_address", limit: 60
    t.string "type_depotage", limit: 40
    t.boolean "accord_client"
    t.text "comment"
    t.string "reference", limit: 30
    t.datetime "date_agent_notified"
    t.datetime "date_agency_notified"
    t.datetime "date_client_notified"
    t.datetime "date_banque_notified"
    t.string "email_agency", limit: 60
    t.string "email_client", limit: 60
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_of_lading_number"], name: "index_refund_requests_on_bill_of_lading_number"
    t.index ["date_demande"], name: "index_refund_requests_on_date_demande"
    t.index ["reason_for_refund"], name: "index_refund_requests_on_reason_for_refund"
    t.index ["status"], name: "index_refund_requests_on_status"
  end

  add_foreign_key "bill_of_ladings", "customers"
  add_foreign_key "invoices", "bill_of_ladings", column: "bill_of_lading_number", primary_key: "number"
end
