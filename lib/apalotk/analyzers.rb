Dir[File.dirname(__FILE__) + '/analyzers/*.rb'].each do |f|
  require f
end
