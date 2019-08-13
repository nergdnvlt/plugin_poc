class FastspringAccountService
  def self.build(params)
    new(params).build
  end

  def build
    FastspringOrderService.call(@order_id)
  end

  private

  def initialize(params)
    @params = params
    @user = User.find_or_create_by(fs_id: user_params[:fs_id])
    @order_id = params[:order][:orderId]
  end

  def user_params
    @params.require(:user).permit(:fs_id)
  end
end