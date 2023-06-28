class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
    if @food.save
      redirect_to root_path, notice: 'Food added successfully.'
    else
      redirect_to root_path, notice: 'Error! Food not added.'
    end
  end

  def destroy
    @food = Food.find_by(params[:id])

    if @food.destroy
      flash[:notice] = 'Food deleted successfully.'
    else
      flash[:alert] = 'Error! Food not deleted.'
    end
  end

  private
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end

end
