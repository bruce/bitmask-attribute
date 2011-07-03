class ActiveSupport::TestCase
  
  def assert_unsupported(&block)
    assert_raises(ArgumentError, &block)
  end
  
  def assert_stored(record, *values)
    values.each do |value|
      assert record.medium.any? { |v| v.to_s == value.to_s }, "Values #{record.medium.inspect} does not include #{value.inspect}"
    end
    full_mask = values.inject(0) do |mask, value|
      mask | Campaign.bitmasks[:medium][value]
    end
    assert_equal full_mask, record.medium.to_i
  end
  
end