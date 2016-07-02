class Product
  attr_reader :title

  @@products = []

  def initialize(options = {})
    @title = options[:title]
    add_to_products
  end

  def self.all
    @@products
  end

  private

  def add_to_products
    raise DuplicateProductError, "#{title} already exists." if find_duplicate
    @@products << self
  end

  def find_duplicate
    @@products.map(&:title).include?(title)
  end
end
