class CreateAccessAudits < ActiveRecord::Migration[6.0]
    def change
      create_table :access_audits do |t|
        t.references :user, null: false, foreign_key: true
        t.references :record, polymorphic: true, null: false
        t.string :field_name, null: false
        t.datetime :accessed_at, null: false
  
        t.timestamps
      end
    end
  end
  