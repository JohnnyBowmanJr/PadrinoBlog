PadrinoBlog::App.controller :posts do

	get :index do	
		@posts = Post.all 

		render 'posts/index'
	end

	get :index, :map => 'posts/author/:author/' do
		id = Author.where("name = ?", params[:author]).first.id
		@posts = Post.where("author_id = ?", id)
		render 'posts/index'
	end	
 
 	get :index, :map => 'posts/author/:author/:id' do 
		id = Author.where("name = ?", params[:author]).first.id
 		@posts = Post.where("author_id = ? and id = ?", id, params[:id]) 
 		render 'posts/index'
 	end

 	get :index, :map => 'posts/tagged/:tag' do
 		tag_id = Tag.where("name = ?", params[:tag]).first.id
 		post_id = PostTag.where("post_id = ?", tag_id).first.id
 		@posts = Post.where("id = ?", post_id)
 		render 'posts/index'
 	end

 	get :index, :map => 'archive/:year/:month' do
 		case params[:year]
 		when "2013"
 			@posts = Post.where("created_at > ?", Time.local(2012, 12, 31))
 			case params[:month]
 			when "March"
 				@posts = Post.where("created_at > ? and created_at < ?", Time.local(2013, 3, 1), Time.local(2013,3,28))
 			end
 		when "2012"
 			@posts = Post.where("created_at < ?", Time.local(2013, 1, 1))
		else
 			@posts = Post.all
		end

		render 'posts/index'
	end
 				
 		





	# get :index do
	# 	@posts = Tag.find_by_name(params[:name]).posts

	# 	OR

	# 	#update posts set created_at = '2013-04-11' where id=1;
	# 	@post = Post.where("created_at > ? and created_at < ?", Time.local(2013, 2, 1), Time.local(2013,2,28))
	# 	render 'posts/index'
	# end

end