class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = current_user
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      flash[:notice] = 'Recipe saved successfully'
      redirect_to recipes_path
    else
      flash[:notice] = 'Failed to save Recipe!'
      redirect_to recipes_path
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])

    if @recipe.destroy
      flash[:notice] = 'Recipe deleted successfully.'
      redirect_to recipes_path
    else
      flash[:alert] = 'Error! Recipe not deleted.'
      redirect_to recipes_path
    end
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_to @recipe
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description)
  end

end
