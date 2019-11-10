class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  # Authorization: for users who are NOT signed in.
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :seller]
  # Authorization: for signed in users
  before_action :check_user, only: [:edit, :update, :destroy]

  # When current_user goes to the seller page this method will only display the listings the current user owns
  def seller
    @listings = Listing.where(user: current_user).order("created_at DESC")
  end

  # GET /listings
  # GET /listings.json
  # Redirect to stop users from typing in page numbers in the url where no listings exist.
  def index
    @listings = Listing.paginate(page: params[:page], per_page: 8)
    redirect_to root_path if @listings.empty?
    # @listings.length
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @foo = "bar"
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.productimage.attach(listing_params[:productimage])
    @listing.user_id = current_user.id

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        #15
        @listing.productimage.attach(listing_params[:productimage]) if listing_params[:productimage]
        format.html { redirect_to @listing, notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_listing
    @listing = Listing.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def listing_params
    params.require(:listing).permit(:item, :price, :location, :description, :productimage, :user_id)
  end

  # Authorization: Checks if user owns the listing
  def check_user
    if current_user != @listing.user
      redirect_to root_url, alert: "Sorry, this listing belongs to someone else"
    end
  end
end
