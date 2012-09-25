class Product < ActiveRecord::Base
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item
  # Validation constants
  TITLE_LENGTH = 10

  attr_accessible :description, :image_url, :price, :title

  # presence: true tells the validator to check that each of the named fields
  # is present and its contents are not empty.
  validates :title, :description, :image_url, presence: true

  # We’ll use the delightfully named numericality() option to verify that the
  # price is a valid number.
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  # The uniqueness validation will perform a simple check to ensure that no
  # other row in the products table has the same title as the row we’re about
  # to save
  validates :title, uniqueness: true

  # We need to validate that the URL entered for the image is valid. We’ll do
  # this using the format option, which matches a field against a regular
  # expres- sion. 
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|png)\Z/i,
    message: 'must be a URL for GIF, JPG, or PNG image.'
  }

  # Playtime: The validation option :length checks the length of a model
  # attribute. Add validation to the Product model to check that the title is
  # at least ten charac- ters long.
  validates :title, length: { minimum: TITLE_LENGTH }

  private

  # Define a hook method named ensure_not_referenced_by_any_line_item(). A hook
  # method is a method that Rails calls automatically at a given point in an
  # object’s life. In this case, the method will be called before Rails
  # attempts to destroy a row in the database. If the hook method returns
  # false, the row will not be destroyed.
  #
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add :base, 'Line Items present'
      return false
    end
  end
end
