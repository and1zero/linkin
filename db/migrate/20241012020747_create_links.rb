class CreateLinks < ActiveRecord::Migration[7.2]
  def change
    create_table :links do |t|
      t.string :original_url
      t.string :short_url

      t.timestamps
    end
  end
end
