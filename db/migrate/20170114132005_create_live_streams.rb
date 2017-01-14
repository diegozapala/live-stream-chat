class CreateLiveStreams < ActiveRecord::Migration[5.0]
  def change
    create_table :live_streams do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
