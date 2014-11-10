require "active_record"
require "yaml"
require "stackflame"

ActiveRecord::Base.configurations["profile"] = {
  adapter: "sqlite3",
  database: "test.sqlite3",
  pool: 5,
  timeout: 5000,
}
ActiveRecord::Base.establish_connection :profile

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.column :created_at, :datetime
    t.column :updated_at, :datetime
  end
end

class User < ActiveRecord::Base; end
100.times { User.create }

Stackflame.profile do
  User.all.to_a
end
