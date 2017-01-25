# AddDomainRefToEmails
class AddDomainRefToEmails < ActiveRecord::Migration[5.0]
  def change
    add_reference :emails, :domain, type: :bigint, index: true
    add_foreign_key :emails, :domains, on_delete: :cascade
  end
end
