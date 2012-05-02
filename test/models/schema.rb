ActiveRecord::Schema.define do

  create_table :bulbs, :force => true do |t|
    t.integer :car_id
    t.string  :name
    t.boolean :frickinawesome
    t.string :color
  end

  create_table :cars, :force => true do |t|
    t.string  :name
    t.integer :engines_count
    t.integer :wheels_count
  end

  create_table :people, :force => true do |t|
    t.string     :first_name, :null => false
    t.string     :gender, :limit => 1
    t.string     :comments
    t.timestamps
  end

end
