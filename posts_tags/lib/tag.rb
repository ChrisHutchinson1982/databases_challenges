class Tag
  attr_accessor :id, :name, :posts

  def initialize
    @posts = []
  end
end