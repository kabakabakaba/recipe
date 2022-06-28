class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.user_recipes_get(current_user.id)
  end

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.user_recipe_get(current_user.id, params[:id])
    redirect_to recipes_path, status: :found, alert: 'レシピにアクセス出来ません' if @recipe.nil?
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    recipe = Recipe.new(recipe_params)
    if recipe.save
      redirect_to recipes_path, notice: 'レシピを登録完了！'
    else
      flash[:alert] = 'レシピの登録に失敗しました。'
      render :new
    end
  end

  def update
    recipe = Recipe.find(params[:id])
    if recipe.update(recipe_params)
      redirect_to recipe_path(params[:id]), notice: 'レシピを変更しました。'
    else
      flash[:alert] = 'レシピの登録に失敗しました。'
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    recipe_name = @recipe.name
    @recipe.destroy!
    redirect_to recipes_path, notice: "#{recipe_name}のレシピを削除しました"
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :text).merge(user_id: current_user.id)
  end
end
