class CreateDailyAwards < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_awards do |t|
      t.references :user, foreign_key: true
      t.integer :number_messages_sent

      t.timestamps
    end
  end
end
