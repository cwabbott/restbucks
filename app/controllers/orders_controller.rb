class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  respond_to :json

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    next_url = {}
    next_url = {next: {profile: "http://#{my_address}:3000/pickup", href: "http://#{my_address}:3000/orders/pickup/#{@order.id}", enctype: 'application/json'}} if @order.status == "ready"
    respond_to do |format|
      response_json = { drink: @order.drink, status: @order.status, additions: @order.additions, _links: next_url}
      format.json { render json: response_json, status: 200 }
    end
  end
  
  def pickup
    @order = Order.find(params['id'])
    @order.status = 'served'
    @order.save
    respond_to do |format|
      response_json = {message: "thank you, come again!",  _links: { next: {profile: "http://#{my_address}:3000/order", href: "http://#{my_address}:3000/orders/#{@order.id}", enctype: 'application/json'}}}
      format.json { render json: response_json, status: 200 }
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @drink = Drink.where(drink: @order.drink).first
    if @drink.nil?
      respond_to do |format|
        format.json { render json: {}, status: 404}
      end
    else
      respond_to do |format|
        if @order.save
          @drink = Drink.where(drink: @order.drink).first
          format.html { redirect_to @order, notice: 'Order was successfully created.' }
          response_json = {drink: @drink.drink, cost: @drink.cost, _links: { next: {profile: "http://#{my_address}:3000/payment", href: "http://#{my_address}:3000/payments/order/#{@order.id}", enctype: 'application/json'}}}
          format.json { render json: response_json, status: :created, location: @order }
        else
          format.html { render action: 'new' }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.status == "preparing"
        format.json { render text: '', status: 409 }
      else
        if @order.update(order_params)
          @drink = Drink.where(drink: @order.drink).first
          format.html { redirect_to @order, notice: 'Order was successfully updated.' }
          response_json = {drink: @drink.drink, cost: @drink.cost, additions: @order.additions, _links: { next: {profile: "http://#{my_address}:3000/payment", href: "http://#{my_address}:3000/payments/order/#{@order.id}", enctype: 'application/json'}}}
          format.json { render text: response_json, status: :created, location: @order }
        
        else
          format.html { render action: 'edit' }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:drink, :additions, :status)
    end
    
    def barista_params
      params.require(:order).permit(:status)
    end
end
