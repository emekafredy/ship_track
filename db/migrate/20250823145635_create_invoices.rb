class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.string :reference, null: false, limit: 10
      t.string :numero_bl, null: false, limit: 9
      t.string :code_client, null: false, limit: 20
      t.string :nom_client, null: false, limit: 60
      t.decimal :montant_facture, null: false, precision: 12, scale: 0
      t.decimal :montant_orig, precision: 12, scale: 2
      t.string :devise, limit: 6, default: 'USD'
      t.string :statut, null: false, limit: 10, default: 'init'
      t.datetime :date_facture, null: false
      t.integer :id_utilisateur, null: false, limit: 8
      t.string :create_type_utilisateur, limit: 20
      t.integer :id_utilisateur_update, limit: 8

      t.timestamps
    end

    add_index :invoices, :reference, unique: true
  end
end
