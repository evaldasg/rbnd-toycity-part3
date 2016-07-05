class Customer
  attr_reader :name

  @@customers = []

  def initialize(options = {})
    @name = options[:name]
    add_to_customers
  end

  def purchase(product)
    Transaction.new(self, product)
  end

  def return_item(product)
    purchases = Transaction.find_by(customer_name: name).select { |transaction| transaction.product == product }
    purchases.first.delete
  end

  class << self
    def all
      @@customers
    end

    def find_by_name(lookup_name)
      @@customers.find { |customer| customer.name == lookup_name }
    end
  end

  private

  def add_to_customers
    raise DuplicateProductError, "'#{name}' already exists." if find_duplicate
    @@customers << self
  end

  def find_duplicate
    @@customers.map(&:name).include?(name)
  end
end
