class UpdateInvoiceColumns < ActiveRecord::Migration[7.2]
  def change
    add_column :invoices, :due_date, :date
    rename_column :invoices, :date_facture, :invoice_date
    rename_column :invoices, :id_utilisateur, :customer_id
    rename_column :invoices, :id_utilisateur_update, :customer_id_update
  end
end
