# frozen_string_literal: true

# BEGIN
require 'uri'
require 'forwardable'

class Url
  extend Forwardable
  include Comparable

  def initialize(url_str)
    @uri = URI(url_str)
    @query_params = parse_query_params(@uri.query)
  end

  def_delegators :@uri, :scheme, :host, :port

  def query_params
    @query_params
  end

  def query_param(key, default = nil)
    @query_params.fetch(key.to_sym, default)
  end

  def <=>(other)
    return nil unless other.is_a?(Url)
    comp = [scheme, host, port] <=> [other.scheme, other.host, other.port]
    return comp unless comp.zero?
    @query_params.to_a.sort <=> other.query_params.to_a.sort
  end

  private

  def parse_query_params(query)
    return {} if query.nil? || query.empty?
    result = {}
    query.split('&').each do |p|
      par = p.split('=')
      result[par[0].to_sym] = par[1]
    end
    result
  end
end
# END
