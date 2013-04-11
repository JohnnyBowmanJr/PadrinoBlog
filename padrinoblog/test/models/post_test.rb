require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class PostTest < Test::Unit::TestCase
  context "Post Model" do
    setup do
    	@post = Post.new(:title => "My first post", :body => "This is the body")
    	@post.author = Author.new(:name => "Johnny")
   
    	@tag = Tag.new(:name => "WDI")
    	@post.tags << @tag
    	@post.save
    	@post.reload
    end
  
    should "have many post_tags" do
	  	assert_equal 1, @post.post_tags.length
	  	assert @post.post_tags.is_a?(Array)
	  	assert @post.post_tags.first.is_a?(PostTag)
	  	assert @post.post_tags.first.tag.is_a?(Tag)
	  	assert_equal @tag, @post.post_tags.first.tag
  	end

  	 should 'belongs_to Author' do
	  	assert @post.respond_to?(:author)
	  	assert_not_nil @post.author
	  	assert @post.author.is_a?(Author)
  	end

  end
end
