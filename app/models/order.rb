class Order < ActiveRecord::Base
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]

  has_many :line_items, dependent: :destroy

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  attr_accessible :address, :email, :name, :pay_type

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      # We set the cart_id to nil in order to prevent the item from going poof
      # when we destroy the cart.
      item.cart_id = nil

      # Add the item itself to the line_items collection for the order. Notice
      # that we didn’t have to do anything special with the various foreign key
      # fields, such as setting the order_id column in the line item rows to
      # reference the newly created order row. Rails does that knitting for us
      # using the has_many() and belongs_to() declarations we added to the
      # Order and LineItem models. Appending each new line item to the
      # line_items collection hands the responsibility for key management over
      # to Rails.
      line_items << item
    end
  end
end
