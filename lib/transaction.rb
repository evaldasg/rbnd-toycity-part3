class Transaction
  attr_reader :id, :customer, :product

  @@transactions = []

  def initialize(customer, product)
    @customer = customer
    @product = product.reduce_stock
    @id = @@transactions.map(&:id).max.to_i + 1
    @@transactions << self
  end

  class << self
    def all
      @@transactions
    end

    def find(id)
      @@transactions.find { |transaction| transaction.id == id }
    end
  end
end
