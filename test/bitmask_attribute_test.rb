require 'test_helper'

class BitmaskAttributeTest < Test::Unit::TestCase
  
  context "Campaign" do

    should "can assign single value to bitmask" do
      assert_stored Campaign.new(:medium => :web), :web
    end

    should "can assign multiple values to bitmask" do
      assert_stored Campaign.new(:medium => [:web, :print]), :web, :print
    end

    should "can add single value to bitmask" do
      campaign = Campaign.new(:medium => [:web, :print])
      assert_stored campaign, :web, :print
      campaign.medium << :phone
      assert_stored campaign, :web, :print, :phone
    end

    should "ignores duplicate values added to bitmask" do
      campaign = Campaign.new(:medium => [:web, :print])
      assert_stored campaign, :web, :print
      campaign.medium << :phone
      assert_stored campaign, :web, :print, :phone
      campaign.medium << :phone
      assert_stored campaign, :web, :print, :phone
      assert_equal 1, campaign.medium.select { |value| value == :phone }.size
    end

    should "can assign new values at once to bitmask" do
      campaign = Campaign.new(:medium => [:web, :print])
      assert_stored campaign, :web, :print
      campaign.medium = [:phone, :email]
      assert_stored campaign, :phone, :email
    end

    should "can save bitmask to db and retrieve values transparently" do
      campaign = Campaign.new(:medium => [:web, :print])
      assert_stored campaign, :web, :print
      assert campaign.save
      assert_stored Campaign.find(campaign.id), :web, :print
    end

    should "can add custom behavor to value proxies during bitmask definition" do
      campaign = Campaign.new(:medium => [:web, :print])
      assert_raises NoMethodError do
        campaign.medium.worked?
      end
      assert_nothing_raised do
        campaign.misc.worked?
      end
      assert campaign.misc.worked?
    end

    should "cannot use unsupported values" do
      assert_unsupported { Campaign.new(:medium => [:web, :print, :this_will_fail]) }
      campaign = Campaign.new(:medium => :web)
      assert_unsupported { campaign.medium << :this_will_fail_also }
      assert_unsupported { campaign.medium = [:so_will_this] }
    end

    should "can determine bitmasks using convenience method" do
      assert Campaign.bitmask_for_medium(:web, :print)
      assert_equal(
        Campaign.bitmasks[:medium][:web] | Campaign.bitmasks[:medium][:print],
        Campaign.bitmask_for_medium(:web, :print)
      )
    end

    should "assert use of unknown value in convenience method will result in exception" do
      assert_unsupported { Campaign.bitmask_for_medium(:web, :and_this_isnt_valid)  }
    end

    should "hash of values is with indifferent access" do
      string_bit = nil
      assert_nothing_raised do
        assert (string_bit = Campaign.bitmask_for_medium('web', 'print'))
      end
      assert_equal Campaign.bitmask_for_medium(:web, :print), string_bit
    end

    should "save bitmask with non-standard attribute names" do
      campaign = Campaign.new(:Legacy => [:upper, :case])
      assert campaign.save
      assert_equal [:upper, :case], Campaign.find(campaign.id).Legacy
    end

    should "ignore blanks fed as values" do
      campaign = Campaign.new(:medium => [:web, :print, ''])
      assert_stored campaign, :web, :print
    end
    
    should "can check if a value is set" do
      campaign = Campaign.new(:medium => [:web, :print])
      
      assert campaign.medium_for_web?
      assert campaign.medium_for_print?
      assert !campaign.medium_for_email?
      
      campaign = Campaign.new
      
      assert !campaign.medium_for_web?
      assert !campaign.medium_for_print?
      assert !campaign.medium_for_email?
    end

    should "find by bitmask values" do
      campaign = Campaign.new(:medium => [:web, :print])
      assert campaign.save
      
      assert_equal(
        Campaign.find(:all, :conditions => ['medium & ? <> 0', Campaign.bitmask_for_medium(:print)]),
        Campaign.medium_for_print
      )
      
      assert_equal Campaign.medium_for_print, Campaign.medium_for_print.medium_for_web
      
      assert_equal [], Campaign.medium_for_email
      assert_equal [], Campaign.medium_for_web.medium_for_email
    end

    #######
    private
    #######

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

end
