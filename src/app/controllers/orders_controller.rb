class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  # Only allow signed in users to place orders
  before_action :authenticate_user!

  # Tells rails to display all listings the 'current_user' is selling
  def sales
    @orders = Order.all.where(seller: current_user).order("created_at DESC")
  end

  # Tells rails to display all listings the 'current_user' has purchased
  def purchases
    @orders = Order.all.where(buyer: current_user).order("created_at DESC")
  end

  # GET /orders/new
  def new
    @order = Order.new
    # Orders are assigned the listing_id in routes
    @listing = Listing.find(params[:listing_id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    # Orders are assigned the listing_id in routes
    @listing = Listing.find(params[:listing_id])

    # Tells rails seller is equal to the user who created the listing
    @seller = @listing.user
    # Order ID = listing ID
    @order.listing_id = @listing.id
    # Tells rails to set the 'buyer_id' column to current user placing the order.
    @order.buyer_id = current_user.id
    @order.seller_id = @seller.id

    respond_to do |format|
      if @order.save
        format.html { redirect_to root_url, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:name, :address, :city, :state, :postcode, :phonenumber, :email)
  end
end
