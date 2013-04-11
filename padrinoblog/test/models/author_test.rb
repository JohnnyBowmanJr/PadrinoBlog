require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class AuthorTest < Test::Unit::TestCase
  context "Author Model" do
    setup do
    	@author = Author.new(:name => "Johnny")
  		@author.comments << Comment.new(:body => "You're gay")
  		@author.comments << Comment.new(:body => "This is dumb")
		end

		should 'test that Author has many comments' do
      assert @author.respond_to?(:comments)
      assert_not_nil @author.comments
      assert @author.comments.is_a?(Array)
      assert_equal 2, @author.comments.length
      assert "You're gay", @author.comments.first.body
    end
  end
end
