
class FastspringProductRegService
  def self.populate(resp)
    new(resp).call?
  end

  def call?
    return true if @user && @order
  end

  private

  def initialize(resp)
    @user = populate_user(resp)
    @order = build_order(resp)
    @line_items = populate_order(format_order(resp))
  end

  def populate_user(resp_ob)
    raw_user = format_user(resp_ob)
    user = User.find_by(fs_id: raw_user[:fs_id])
    user.first_name = raw_user[:first_name] if user.first_name == nil
    user.last_name = raw_user[:last_name] if user.last_name == nil
    user.email = raw_user[:email] if user.email == nil
    user.country = raw_user[:country] if user.country == nil
    user.zipcode = raw_user[:zipcode] if user.zipcode == nil
    if user.save!
      user
    else
      false
    end
  end

  def build_order(resp_ob)
    raw_order = format_order(resp_ob)
    order = @user.orders.create(
      order_id: raw_order[:order_id],
      total: raw_order[:total]
    )
    order
  end

  def populate_order(order_info)
    order_info[:products].each do |product|
      db_product = Product.find_by(path: product[:product])
      product[:quantity].times do
        @order.line_items.create!(
          product_id: db_product.id,
          active: order_info[:active]
        )
      end
    end
  end

  def format_user(resp_ob)
    {
      fs_id: resp_ob[:recipients][0][:recipient][:account],
      first_name: resp_ob[:customer][:first],
      last_name: resp_ob[:customer][:last],
      email: resp_ob[:customer][:email],
      country: resp_ob[:address][:country],
      zipcode: resp_ob[:address][:postalCode],
    }
  end

  def format_order(resp_ob)
    {
      order_id: resp_ob[:order],
      products: products_arr(resp_ob[:items]),
      total: resp_ob[:total],
      active: resp_ob[:completed]
    }
  end

  def products_arr(items)
    items.map do |item|
      product = Hash.new
      product[:product] = item[:product]
      product[:quantity] = item[:quantity]
      product
    end
  end
end