require 'spec_helper'

describe Variant, " instance methods" do
  before(:each) do
    @variant = Factory(:variant)
  end
  # OUT_OF_STOCK_QTY = 2
  # LOW_STOCK_QTY    = 6
  context ".sold_out?" do
    it 'should be sold out' do
      @variant.count_on_hand             = 100
      @variant.count_pending_to_customer = 100 - Variant::OUT_OF_STOCK_QTY
      @variant.sold_out?.should be_true
    end

    it 'should not be sold out' do
      @variant.count_on_hand             = 100
      @variant.count_pending_to_customer = 99 - Variant::OUT_OF_STOCK_QTY
      @variant.sold_out?.should be_false
    end

  end

  context ".low_stock?" do
      it 'should be low stock' do
        @variant.count_on_hand             = 100
        @variant.count_pending_to_customer = 101 - Variant::OUT_OF_STOCK_QTY
        @variant.low_stock?.should be_true
      end

      it 'should be low stock' do
        @variant.count_on_hand             = 100
        @variant.count_pending_to_customer = 100 - Variant::LOW_STOCK_QTY
        @variant.low_stock?.should be_true
      end

      it 'should not be low stock' do
        @variant.count_on_hand             = 100
        @variant.count_pending_to_customer = 99 - Variant::LOW_STOCK_QTY
        @variant.low_stock?.should be_false
      end
  end

  context "featured_image" do

    it 'should return no_image url' do
      @variant.featured_image.should        == 'no_image_small.jpg'
      @variant.featured_image(:mini).should == 'no_image_mini.jpg'
    end
  end

  context ".display_stock_status(start = '(', finish = ')')" do
    it 'should be low stock' do
      @variant.count_on_hand             = 100
      @variant.count_pending_to_customer = 100 - Variant::LOW_STOCK_QTY
      @variant.display_stock_status.should == '(Low Stock)'
    end

    it 'should be sold out' do
      @variant.count_on_hand             = 100
      @variant.count_pending_to_customer = 100 - Variant::OUT_OF_STOCK_QTY
      @variant.display_stock_status.should == '(Sold Out)'
    end
  end

  context ".product_tax_rate(state_id, tax_time = Time.now)" do
    it 'should return the products tax rate for the given state' do
      tax_rate = Factory(:tax_rate)
      @variant.product.stubs(:tax_rate).returns(tax_rate)
      @variant.product_tax_rate(1).should == tax_rate
    end
  end

  context ".shipping_category_id" do
    it 'should return the products shipping_category' do
      @variant.product.stubs(:shipping_category_id).returns(32)
      @variant.shipping_category_id.should == 32
    end
  end

  context ".display_property_details(separator = '<br/>')" do
    # variant_properties.collect {|vp| [vp.property.display_name ,vp.description].join(separator) }
    it 'should show all property details' do
      property      = Factory(:property)
      property.stubs(:display_name).returns('Color')
      variant_prop1 = Factory(:variant_property, :property => property, :description => 'red')
      variant_prop2 = Factory(:variant_property, :property => property, :description => 'blue')
      @variant.variant_properties.push(variant_prop1)
      @variant.variant_properties.push(variant_prop2)
      @variant.display_property_details.should == 'Color: red<br/>Color: blue'
    end
  end

  context ".property_details(separator = ': ')" do
    it 'should show the property details' do
      property      = Factory(:property)
      property.stubs(:display_name).returns('Color')
      variant_prop1 = Factory(:variant_property, :property => property, :description => 'red')
      variant_prop2 = Factory(:variant_property, :property => property, :description => 'blue')
      @variant.variant_properties.push(variant_prop1)
      @variant.variant_properties.push(variant_prop2)
      @variant.property_details.should == ['Color: red', 'Color: blue']
    end
    it 'should show the property details without properties' do
      @variant.property_details.should == []
    end
  end

  context ".product_name" do
    it 'should return the variant name' do
      @variant.name = 'helloo'
      @variant.product.name = 'product says hello'
      @variant.product_name.should == 'helloo'
    end

    it 'should return the products name' do
        @variant.name = nil
        @variant.product.name = 'product says hello'
        @variant.product_name.should == 'product says hello'
    end

    it 'should return the products name and subname' do
        @variant.name = nil
        @variant.product.name = 'product says hello'
        @variant.stubs(:primary_property).returns  Factory(:variant_property, :description => 'pp_name')
        @variant.product_name.should == 'product says hello(pp_name)'
    end
  end

  context ".sub_name" do
    it 'should return the variants subname' do
        @variant.name = nil
        @variant.product.name = 'product says hello'
        @variant.stubs(:primary_property).returns  Factory(:variant_property, :description => 'pp_name')
        @variant.sub_name.should == '(pp_name)'
    end
  end

  context ".brand_name" do
    it 'should return the variants subname' do
        @variant.stubs(:brand).returns  Factory(:brand, :name => 'Nike')
        @variant.brand_name.should == 'Nike'
    end
  end

  context ".primary_property" do
    it 'should return the primary property' do
      property      = Factory(:property)
      property2      = Factory(:property)
      property.stubs(:display_name).returns('Color')
      variant_prop1 = Factory(:variant_property, :variant => @variant, :property => property, :primary => true)
      variant_prop2 = Factory(:variant_property, :variant => @variant, :property => property2, :primary => false)
      @variant.variant_properties.push(variant_prop2)
      @variant.variant_properties.push(variant_prop1)
      @variant.primary_property.should == variant_prop1
    end

    it 'should return the primary property' do
      property      = Factory(:property)
      property2      = Factory(:property)
      property.stubs(:display_name).returns('Color')
      variant_prop1 = Factory(:variant_property, :variant => @variant, :property => property, :primary => true)
      variant_prop2 = Factory(:variant_property, :variant => @variant, :property => property2, :primary => false)
      @variant.variant_properties.push(variant_prop1)
      @variant.variant_properties.push(variant_prop2)
      @variant.save
      @variant.primary_property.should == variant_prop1
    end
  end

  context ".name_with_sku" do
    it "should show name_with_sku" do
      @variant.name = 'helloo'
      @variant.sku = '54321'
      @variant.name_with_sku.should == 'helloo: 54321'
    end
  end

  context ".qty_to_add" do
    it "should return 0 for qty_to_add" do
      @variant.qty_to_add.should == 0
    end
  end

  context ".is_available?" do
    it "should be available" do
      @variant.count_on_hand             = 100
      @variant.count_pending_to_customer = 99
      @variant.save
      @variant.is_available?.should be_true
    end

    it "should not be available" do
      @variant.count_on_hand             = 100
      @variant.count_pending_to_customer = 100
      @variant.save
      @variant.is_available?.should be_false
    end
  end

  context ".count_available(reload_variant = true)" do
    it "should return count_available" do
      @variant.count_on_hand             = 100
      @variant.count_pending_to_customer = 99
      @variant.save
      @variant.is_available?.should be_true
    end
  end

  context ".add_count_on_hand(num)" do
    it "should update count_on_hand" do
      @variant.count_on_hand             = 100
      @variant.count_pending_to_customer = 99
      @variant.save
      @variant.add_count_on_hand(1)
      @variant.reload
      @variant.count_on_hand.should == 101
    end
  end

  context ".subtract_count_on_hand(num)" do
    it "should update count_on_hand" do
      @variant.count_on_hand             = 100
      @variant.count_pending_to_customer = 99
      @variant.save
      @variant.subtract_count_on_hand(1)
      @variant.reload
      @variant.count_on_hand.should == 99
    end
  end

  context ".add_pending_to_customer(num)" do
    it "should update count_on_hand" do
      @variant.count_on_hand             = 100
      @variant.count_pending_to_customer = 99
      @variant.save
      @variant.add_pending_to_customer(1)
      @variant.reload
      @variant.count_pending_to_customer.should == 100
    end
  end

  context ".subtract_pending_to_customer(num)" do
    it "should update subtract_pending_to_customer" do
      @variant.count_on_hand             = 100
      @variant.count_pending_to_customer = 99
      @variant.save
      @variant.subtract_pending_to_customer(1)
      @variant.reload
      @variant.count_pending_to_customer.should == 98
    end
  end

  context ".qty_to_add=(num)" do
    it "should update count_on_hand with qty_to_add" do
      @variant.count_on_hand             = 100
      @variant.qty_to_add = 12
      @variant.count_on_hand.should == 112
    end
  end
end

describe Variant, "#admin_grid(product, params = {})" do
  it "should return variants for a specific product" do
    product = Factory(:product)
    variant1 = Factory(:variant, :product => product)
    variant2 = Factory(:variant, :product => product)
    admin_grid = Variant.admin_grid(product)
    admin_grid.size.should == 2
    admin_grid.should == [variant1, variant2]
  end
end
