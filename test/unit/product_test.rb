require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # We want Rails to load the test data into the products table when we run the
  # unit test. And, in fact, Rails is already doing this (convention over
  # configuration for the win!), but you can control which fixtures to load by
  # specifying the following line
  fixtures :products

  def new_product(image_url)
    Product.new title: "my book title", description: "yyy", price: 1, image_url: image_url
  end

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  

  test "product price must be positive" do
    product = Product.new title: "my book title", description: "yyy", image_url: "zzz.jpg"
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
    
    product.price = 1
    assert product.valid?
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
             http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title, 
                          description: "yyy",
                          price: 1,
                          image_url: "fred.gif")
    assert product.invalid?
    assert_equal [I18n.translate('activerecord.errors.messages.taken')],
      product.errors[:title]
  end

  test "should have a title length of at least 10" do
    product = products(:ruby)

    # Test shortness
    product.title = "short"
    assert product.invalid?
    assert_equal ["is too short (minimum is 10 characters)"], product.errors[:title]
    
    # Valid title
    product.title = "long enough"
    assert product.valid?
  end
end
