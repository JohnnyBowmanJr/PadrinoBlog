require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class TagTest < Test::Unit::TestCase
  context "Tag Model" do
    
    setup do
    	@tag = Tag.new(:name => "NYC")
    	@tag.posts << Post.new(:title => "My first post", :body => "This is the body")
    end

    should "have many posts" do
	  	binding.pry
	  	assert @tag.respond_to?(:posts)
	  	assert_equal 1, @tag.posts.length
	  	assert @tag.posts.is_a?(Array)
	  	assert @tag.posts.first.is_a?(Post)
	  	assert @tag.posts.first.is_a?(Post)
	  	assert_equal "My first post", @tag.posts.first.title
  	end
  end
end
