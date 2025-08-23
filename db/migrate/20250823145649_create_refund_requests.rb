class CreateRefundRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :refund_requests do |t|
      t.string :numero_bl, null: false, limit: 9
      t.string :montant_demande, limit: 15
      t.string :refund_amount, limit: 15
      t.string :deduction, limit: 15
      t.string :statut, limit: 10, default: 'PENDING'
      t.integer :id_transitaire, null: false, limit: 8
      t.integer :id_transitaire_maison, limit: 8
      t.boolean :transitaire_notifie
      t.boolean :maison_notifie
      t.boolean :banque_notifie
      t.datetime :date_demande
      t.datetime :date_refund_traite
      t.string :type_paiement, limit: 10
      t.string :pret, limit: 10
      t.string :soumis, limit: 10
      t.string :consignee_code, limit: 14
      t.string :refund_party_name, limit: 200
      t.string :beneficiaire, limit: 20
      t.string :deposit_amount, limit: 15
      t.string :reason_for_refund, limit: 200
      t.string :remarks, limit: 250
      t.string :co_code, limit: 20
      t.text :zm_doc_no
      t.string :gl_posting_doc, limit: 15
      t.string :clearing_doc, limit: 15
      t.string :email_address, limit: 60
      t.string :type_depotage, limit: 40
      t.boolean :accord_client
      t.text :comment
      t.string :reference, limit: 30
      t.datetime :date_agent_notified
      t.datetime :date_agency_notified
      t.datetime :date_client_notified
      t.datetime :date_banque_notified
      t.string :email_agency, limit: 60
      t.string :email_client, limit: 60

      t.timestamps
    end

    add_index :refund_requests, :numero_bl
    add_index :refund_requests, :statut
    add_index :refund_requests, :reason_for_refund
    add_index :refund_requests, :date_demande
  end
end
