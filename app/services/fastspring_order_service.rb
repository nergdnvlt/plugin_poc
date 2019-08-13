class FastspringOrderService
  def self.call(order_id)
    new(order_id).call
  end

  def call
    FastspringProductRegService.populate(parsed_response)
  end

  private

  def initialize(order_id)
    @order_id = order_id
  end

  def parsed_response
    JSON.parse(conn.body, symbolize_names: true)
  end

  def conn
    uri = "https://api.fastspring.com"
    conn = Faraday.new(uri)
    conn.basic_auth(ENV['fastspring_username'], ENV['fastspring_password'])
    conn.get("/orders/#{@order_id}")
  end
end