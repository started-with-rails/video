module Searchable
    extend ActiveSupport::Concern
   
    included do
      include Elasticsearch::Model
      include Elasticsearch::Model::Callbacks
   
      def as_indexed_json(_options = {})
        as_json(only: %i[title slug excerpt],
          include: {
            categories: { only: :title }
          }
        )
      end
   
      settings settings_attributes do
        mappings dynamic: false do
          indexes :title, { type: :text, analyzer: 'autocomplete'}
          indexes :slug, type: :text 
          indexes :excerpt, { type: :text, analyzer: 'autocomplete'}
          indexes :categories do
            indexes :title, { type: :text, analyzer: 'autocomplete'}
          end
        end
      end
   
      def self.search(query)
        unless query.blank?
          @search_definition = {
            query: {
              multi_match: {
                query: query,
                fields: ['title','slug', 'excerpt', 'categories.title'],
                fuzziness: 1
              }
            }
          }
        end
        ids = __elasticsearch__.search(@search_definition).map {|r| r.id }
        VideoItem.where(id: ids)
      end
    end

    class_methods do
      def settings_attributes
        {
          index: {
            analysis: {
              analyzer: {
                autocomplete: {
                  type: :custom,
                  tokenizer: :standard,
                  filter: %i[lowercase autocomplete]
                }
              },
              filter: {
                autocomplete: {
                  type: :edge_ngram,
                  min_gram: 3,
                  max_gram: 25
                }
              }
            }
          }
        }
      end
    end
end