Hanami::Model.migration do
  change do
    create_table :clicks do
      primary_key :id
      foreign_key :url_id, :urls, null: false

      column :ip, String, null: false
      column :user_agent, String, null: false
      column :referer, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      # this index will make querying stats much faster
      # if we want to aggregate clicks per URL
      index [:url_id, :created_at]
    end
  end
end
