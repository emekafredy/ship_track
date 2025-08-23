class CreateBillOfLadings < ActiveRecord::Migration[7.2]
  def change
    create_table :bill_of_ladings do |t|
      t.integer :id_upload, limit: 8
      t.datetime :date_upload
      t.string :numero_bl, null: false, limit: 9
      t.references :customer, foreign_key: true
      t.string :consignee_code, limit: 20
      t.string :consignee_name, limit: 60
      t.string :notified_code, limit: 20
      t.string :notified_name, limit: 60
      t.string :vessel_name, limit: 30
      t.string :vessel_voyage, limit: 10
      t.datetime :arrival_date, default: -> { "'1970-01-01 00:00:00'" }
      t.integer :freetime, limit: 2
      t.integer :nbre_20pieds_sec, limit: 1, default: 0
      t.integer :nbre_40pieds_sec, limit: 1, default: 0
      t.integer :nbre_20pieds_frigo, limit: 1, default: 0
      t.integer :nbre_40pieds_frigo, limit: 1, default: 0
      t.integer :nbre_20pieds_special, limit: 1, default: 0
      t.integer :nbre_40pieds_special, limit: 1, default: 0
      t.string :reef, limit: 1, default: ''
      t.string :type_depotage, limit: 30
      t.datetime :date_validite
      t.string :statut, limit: 30
      t.boolean :exempte, null: false, default: false
      t.boolean :blocked_for_refund, null: false, default: false
      t.string :reference, limit: 60
      t.text :comment
      t.boolean :valide
      t.string :released_statut, limit: 20
      t.text :released_comment
      t.string :operator, limit: 20
      t.string :atp, limit: 30
      t.boolean :consignee_caution, null: false, default: false
      t.string :service_contract, limit: 200
      t.string :bank_account, limit: 30
      t.string :bank_name, limit: 30
      t.string :emails, limit: 60
      t.string :telephone, limit: 20
      t.string :place_receipt, limit: 60
      t.string :place_delivery, limit: 60
      t.string :port_loading, limit: 60
      t.string :port_discharge, limit: 60

      t.timestamps
    end

    add_index :bill_of_ladings, :reef
    add_index :bill_of_ladings, :numero_bl
    add_index :bill_of_ladings, :arrival_date
    add_index :bill_of_ladings, :consignee_name
    add_index :bill_of_ladings, :consignee_code
  end
end
