Mongoid.database.collections.select { |collection| collection.name != 'system.indexes' }.each do |collection|
  collection.remove({})
end
