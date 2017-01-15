class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.integer :number_accesses
      t.integer :number_messages_sent
      t.references :live_stream, foreign_key: true

      t.timestamps
    end
  end
end
