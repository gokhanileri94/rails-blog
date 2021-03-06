class CategoriesController < ApplicationController

	##belirtilen metotlar dışında diğer metotlarda hata verecek
	before_action :require_admin, except: [:index, :show]

	def index
	 @category = Category.paginate(page: params[:page], per_page: 3)
	end	

	def new
	 @category = Category.new
	end	

	def create
	 @category = Category.new(category_params)
	 if @category.save
	 	flash[:success] = "Kategori başarıyla kayıt edildi"
	 	redirect_to categories_path
	 else	
	 	render :new
	 end
	end	

	def show
	  @category = Category.find(params[:id])
	  @category_articles = @category.articles.paginate(page: params[:page], per_page: 3)
	end	

	private
	def category_params
		params.require(:category).permit(:name)
	end

	def require_admin
		if !logged_in? || (logged_in? && !current_user.admin?)
			flash[:danger] = "Yalnızca yönetici bu işlemi gerçekleştirebilir"
			redirect_to categories_path
		end
	end	

end	