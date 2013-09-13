require 'spec_helper_min'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)


# -- Custom helpers and matchers -----

RSpec::Matchers.define :satisfy do |formula|
  match do |space|
    !!formula.verify(space)
  end

  failure_message_for_should do |space|
    "#{space.name} should satisfy #{formula}"
  end

  failure_message_for_should_not do |space|
    "#{space.name} should not satisfy #{formula}"
  end
end

Space.send :define_method, :<<  do |atom|
  traits.create! property: atom.property, value: atom.value, description: 'Test'
end

module Helpers
  def atoms *syms
    syms.each { |sym| let(sym) { FactoryGirl.create(:property, name: sym).atom } }
  end

  def spaces *syms
    syms.each { |sym| let(sym) { FactoryGirl.create :space, name: sym } }
  end
end


# -- RSpec configuration -----

RSpec.configure do |config|
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Allow focusing on specs
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.extend Helpers

  # Setup basic Value objects
  config.before :all do
    boolean = ValueSet.create! name: 'Boolean'
    boolean.values.create! name: 'True'
    boolean.values.create! name: 'False'
  end
end
