#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "product fields must not be blank" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be at least one dollar" do
    product = Product.new(
        title: "The Name of our Wind",
        description: "A novel by Patrick Rothfuss.",
        image_url: "kvothe.jpg")
    product.price = -1.00
    assert product.invalid?
    assert_equal ["must be greater than or equal to 1.0"],
        product.errors[:price]
    product.price = 0.99
    assert product.invalid?
    assert_equal ["must be greater than or equal to 1.0"],
        product.errors[:price]
    product.price = 1.00
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: "Foo",
        description: "Blah blah blah.",
        price: 1,
        image_url: image_url)
  end
  test "image url must be valid file type" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
      http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each do |name|
      assert new_product(name).valid?, "#{name} needs to have a valid ending"
    end
    bad.each do |name|
      assert new_product(name).invalid?,
      "#{name} shouldn’t have a valid name"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:wind).title,
        description: "Blah.",
        price: 1,
        image_url: "fred.gif")
    assert product.invalid?
    assert_equal ["has already been taken"],
        product.errors[:title]
  end

end
