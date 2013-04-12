PadrinoBlog::Admin.controllers :post_tags do
  get :index do
    @title = "Post_tags"
    @post_tags = PostTag.all
    render 'post_tags/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'post_tag')
    @post_tag = PostTag.new
    render 'post_tags/new'
  end

  post :create do
    @post_tag = PostTag.new(params[:post_tag])
    if @post_tag.save
      @title = pat(:create_title, :model => "post_tag #{@post_tag.id}")
      flash[:success] = pat(:create_success, :model => 'PostTag')
      params[:save_and_continue] ? redirect(url(:post_tags, :index)) : redirect(url(:post_tags, :edit, :id => @post_tag.id))
    else
      @title = pat(:create_title, :model => 'post_tag')
      flash.now[:error] = pat(:create_error, :model => 'post_tag')
      render 'post_tags/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "post_tag #{params[:id]}")
    @post_tag = PostTag.find(params[:id])
    if @post_tag
      render 'post_tags/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'post_tag', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "post_tag #{params[:id]}")
    @post_tag = PostTag.find(params[:id])
    if @post_tag
      if @post_tag.update_attributes(params[:post_tag])
        flash[:success] = pat(:update_success, :model => 'Post_tag', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:post_tags, :index)) :
          redirect(url(:post_tags, :edit, :id => @post_tag.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'post_tag')
        render 'post_tags/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'post_tag', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Post_tags"
    post_tag = PostTag.find(params[:id])
    if post_tag
      if post_tag.destroy
        flash[:success] = pat(:delete_success, :model => 'Post_tag', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'post_tag')
      end
      redirect url(:post_tags, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'post_tag', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Post_tags"
    unless params[:post_tag_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'post_tag')
      redirect(url(:post_tags, :index))
    end
    ids = params[:post_tag_ids].split(',').map(&:strip).map(&:to_i)
    post_tags = PostTag.find(ids)
    
    if PostTag.destroy post_tags
    
      flash[:success] = pat(:destroy_many_success, :model => 'Post_tags', :ids => "#{ids.to_sentence}")
    end
    redirect url(:post_tags, :index)
  end
end
