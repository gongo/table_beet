steps_for :test do
  REQUIRE_TEST = %w(cola pizza)

  #
  # When to run the test:
  #   | cola  |
  #   | pizza |
  #
  step 'To run the test:' do |table|
    @tests << table.to_a.flatten
  end

  #
  # When to run the test:
  #   | cola   |
  #   | report |
  # Then The test is insufficient
  #
  step 'the test is insufficient' do
    expect(@tests).not_to include(*REQUIRE_TEST)
  end
end
