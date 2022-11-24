class Post
  attr_accessor :id, :title, :tags

  def initialize
    @tags = []
  end
end