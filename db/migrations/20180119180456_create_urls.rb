Hanami::Model.migration do
  change do
    create_table :urls do
      primary_key :id

      column :href, String, null: false

      # similar to rails timestamp
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      # Need to change the unique index to [href, user_id]
      # if we implement user in this system
      index :href, unique: true
    end
  end
end
