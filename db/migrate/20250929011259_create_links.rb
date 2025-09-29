class CreateLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :links do |t|
      t.string :shortened
      t.string :url

      t.timestamps
    end
  end
end
