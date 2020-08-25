# frozen_string_literal: true

class BaseFilteredQuery
  ALLOWED_PARAMS = [].freeze

  def initialize(relation, filter_params = {})
    @relation = relation
    @filter_params = sanitized_filter_params(filter_params)
  end

  def all
    filter_params.reduce(relation) do |relation, (key, value)|
      method_name = "by_#{key}"
      self.class.private_method_defined?(method_name) ? send(method_name, relation, value) : relation
    end
  end

  private

  attr_reader :relation, :filter_params

  def by_per_page(relation, per_page)
    relation.per(per_page)
  end

  def by_page(relation, page)
    relation.page(page)
  end

  def prepare_query_to_search(query)
    [
      "%(",
      query.gsub(/[^[:ascii:]]/, " ").gsub(/([^\w\s])/, '^\1').split(" ").join("|").downcase,
      ")%"
    ].join
  end

  def prepare_query_to_int(query)
    parsed_query = query[/\d+/].to_i
    parsed_query > 2_147_483_647 ? -1 : parsed_query
  end

  def prepare_query_to_ilike_search(query)
    "%#{query}%"
  end

  def convert_to_boolean(value)
    Attributes::TrueBooleanType.new.cast(value)
  end

  def sanitized_filter_params(params)
    params
      .to_h
      .deep_symbolize_keys
      .reject { |k, v| !self.class::ALLOWED_PARAMS.include?(k) || v.to_s.blank? }
  end
end
