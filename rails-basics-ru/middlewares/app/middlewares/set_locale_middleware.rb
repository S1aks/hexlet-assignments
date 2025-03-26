# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end

  # BEGIN
  def call(env)
    dup._call(env)
  end

  def _call(env)
    request = ActionDispatch::Request.new(env)
    locale = extract_locale_from_accept_language_header(request) || I18n.default_locale
    I18n.locale = locale
    log(locale)
    @status, @headers, @response = @app.call(env)
    [@status, @headers, @response]
  end

  private

  def extract_locale_from_accept_language_header(request)
    accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
    return if accept_language.blank?
    accept_language.scan(/^[a-z]{2}/).first&.to_sym
  end

  def log(s)
    Rails.logger.debug('-' * 50)
    Rails.logger.debug("Locale: #{s}")
    Rails.logger.debug('-' * 50)
  end
  # END
end
