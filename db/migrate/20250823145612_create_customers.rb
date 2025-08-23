class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :nom, null: false, limit: 60
      t.string :statut, limit: 20
      t.string :code_client, limit: 20
      t.string :nom_groupe, null: false, limit: 150
      t.boolean :paie_caution, null: false, default: false
      t.integer :freetime_frigo, limit: 2
      t.integer :freetime_sec, limit: 2
      t.boolean :prioritaire, default: false
      t.integer :salesrepid, limit: 8
      t.integer :financerepid, limit: 8
      t.integer :cservrepid, limit: 8
      t.datetime :date_validite
      t.string :operator, limit: 20

      t.timestamps
    end
  end
end
