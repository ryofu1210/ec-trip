class Admin::ItemsController < Admin::AdminBase
  def index
    @search_form = Admin::ItemSearchForm.new(search_params)
    @items = @search_form.search(params[:page])
    session['search_params'] = view_context.search_conditions_keeper(params, [:category_id, :name, :order_type])
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(post_params)
    if @item.save
      flash[:success] = '登録が完了しました。'
      redirect_to admin_items_path(session['search_params'])
    else
      flash.now[:error] = '入力内容をご確認ください。'
      render action: :new
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.assign_attributes(post_params)
    if @item.save
      flash[:success] = '更新が完了しました。'
      redirect_to admin_items_path(session['search_params'])
    else
      flash.now[:error] = '入力内容をご確認ください。'
      render action: :edit
    end
  end

  private
  def search_params
    return  nil if params[:search].nil?
    params.require(:search).permit(:category_id, :name, :sort_type)
  end
  def post_params
    params.require(:item).permit(:name, :description, :caption_image_id, :about, :category_id,
                                    :price, :stock_quantity, :remarks, :status)
  end
end