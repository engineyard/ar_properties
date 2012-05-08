require 'test_helper'
require 'test/unit'

class PropertiesTest < ActiveSupport::TestCase
  def test_attribute_present
    car = Car.create(:name => "Ferrari Testarossa")
    bulb = car.bulbs.create(:name => "Incandescent", :frickinawesome => true)

    assert_equal bulb.car, car
    assert_equal bulb.name, "Incandescent"
    assert_equal bulb.frickinawesome, true

    assert !bulb.respond_to?(:color)
  end

  def test_default_values
    bulb = Bulb.new

    assert_equal bulb.car, nil
    assert_equal bulb.name, nil
    assert_equal bulb.frickinawesome, false
  end

  def test_id_and_timestamps
    person = Person.create(:first_name => "John")

    assert person.id.kind_of?(Integer)
    assert person.created_at.kind_of?(Time)
    assert person.updated_at.kind_of?(Time)
  end

  def test_no_writes_to_unspecified_properties
    person = Person.create(:first_name => "John")

    person.connection.execute("UPDATE people SET comments='hi' WHERE id=#{person.id}")
    original = person.connection.select_values("SELECT comments FROM people WHERE id=#{person.id}")
    person.update_attributes :first_name => "Jane"
    updated = person.connection.select_values("SELECT comments FROM people WHERE id=#{person.id}")
    assert_equal updated, original
  end

  def test_no_duplicate_properties
    assert_equal Bulb.properties.size, 4
  end

  def test_type_constraint
    assert_raise(ActiveRecord::Properties::PropertyError) do
      Class.new(ActiveRecord::Base) do
        property :name, :strang
      end
    end
  end

  def test_timestamps_suffix
    assert_nothing_raised do
      Class.new(ActiveRecord::Base) do
        timestamps :at
      end
    end

    assert_nothing_raised do
      Class.new(ActiveRecord::Base) do
        timestamps :on
      end
    end

    assert_raise(ActiveRecord::Properties::PropertyError) do
      Class.new(ActiveRecord::Base) do
        timestamps :foo
      end
    end
  end

  def test_find_by_sql
    Person.create(:first_name => "John").tap do |p|
      p.connection.execute("UPDATE people SET comments='hi' WHERE id=#{p.id}")
    end

    person = Person.find_by_sql("SELECT * FROM people WHERE comments = 'hi'").first

    assert_equal person.first_name, "John"
    assert_equal person.class, Person
    assert_equal person.comments, "hi"
  end
end
