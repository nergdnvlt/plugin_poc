class LineItem < ApplicationRecord
  before_save :generate_license

  belongs_to :order
  belongs_to :product

  def active?
    if self.active == true
      "Yes"
    else
      "No"
    end
  end

  private

  def generate_license
    if self.active == true
      self.fulfillment = Digest::SHA2.new(256).hexdigest(@data.to_s).to_s[0..9]
    end
  end

  def model_string
    "#{self.order.id}, #{self.product.path}, #{self.active}"
  end
end
