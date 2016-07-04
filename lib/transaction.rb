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

    # find_by takes one hash argument, where key is lookup method, which starts with
    #   customer or product, and then after underscore must be existing attribute of customer or product
    #   f.e.: find_by(cutomer_name: 'Walter Latimer') #=> reutrns an array with customers purchases
    def find_by(lookup)
      resource, attribute = lookup.keys[0].to_s.split('_')
      lookup_value = lookup.values[0]
      @@transactions.select { |transaction| transaction.send(resource).send(attribute) == lookup_value }
    end
  end
end
