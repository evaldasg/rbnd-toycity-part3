class Product
  attr_reader :title, :price, :stock

  @@products = []

  def initialize(options = {})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]
    add_to_products
  end

  def in_stock?
    stock > 0
  end

  def decrement_stock
    raise OutOfStockError, "'#{title}' is out of stock." unless in_stock?
    @stock -= 1
    self
  end

  def increment_stock
    @stock += 1
  end

  class << self
    def all
      @@products
    end

    def find_by_title(lookup_title)
      @@products.find { |product| product.title == lookup_title }
    end

    def in_stock
      @@products.select(&:in_stock?)
    end
  end

  private

  def add_to_products
    raise DuplicateProductError, "'#{title}' already exists." if find_duplicate
    @@products << self
  end

  def find_duplicate
    @@products.map(&:title).include?(title)
  end
end
