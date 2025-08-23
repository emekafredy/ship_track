class RenameRelevantColumnsAndIndexes < ActiveRecord::Migration[7.2]
  def change
    # Remove indexes
    remove_index :bill_of_ladings, :numero_bl

    # Customer columns
    rename_column :customers, :nom, :name
    rename_column :customers, :statut, :status
    rename_column :customers, :code_client, :customer_code
    rename_column :customers, :nom_groupe, :group_name
    rename_column :customers, :paie_caution, :pay_deposit

    # Bill of lading columns
    rename_column :bill_of_ladings, :id_upload, :upload_id
    rename_column :bill_of_ladings, :date_upload, :upload_date
    rename_column :bill_of_ladings, :numero_bl, :number

    # Invoice columns
    rename_column :invoices, :numero_bl, :bill_of_lading_number
    rename_column :invoices, :code_client, :customer_code
    rename_column :invoices, :nom_client, :customer_name
    rename_column :invoices, :montant_facture, :invoice_amount
    rename_column :invoices, :montant_orig, :original_amount
    rename_column :invoices, :devise, :currency
    rename_column :invoices, :statut, :status

    # Refund Request columns
    rename_column :refund_requests, :numero_bl, :bill_of_lading_number
    rename_column :refund_requests, :montant_demande, :requested_amount
    rename_column :refund_requests, :statut, :status

    # Add indexes
    add_index :bill_of_ladings, :number, unique: true

    # Add foreign keys
    add_foreign_key :invoices, :bill_of_ladings, column: :bill_of_lading_number, primary_key: :number
  end
end
