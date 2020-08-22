begin
  Elasticsearch::Model.client = Elasticsearch::Client.new host: ENV['ELASTICSEARCH_URL'] || "http://localhost:9200/"
rescue Exception => e
  Rails.logger.fatal("ElasticSearch.client was not available, message: '#{e.message}'")
  Rails.logger.fatal(e.backtrace.join("\n"))
end
