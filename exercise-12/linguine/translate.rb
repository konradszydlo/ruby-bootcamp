require_relative 'cache'
require_relative 'main'
require_relative 'bing_translator'
require_relative 'google_translator'

class Translator

  attr_reader :from_lang, :to_lang, :translation_engine, :cache

  def initialize(from_lang, to_lang, cache = Cache.new)
    @from_lang = from_lang
    @to_lang = to_lang
    @translation_engine = :google
    # @translation_engine = :bing
    @cache = cache
    @client_secret = 'secret'
  end

  def get_language_content(path)
    case translation_engine
      when :google
        translator = GoogleTranslator.new
      when :bing
        translator = BingTranslator.new('ruby_bootcamp_exercise_12_linguine', @client_secret)
    end

    data = get_file_data(path + '.data')

    unless to_lang == Linguine::DEFAULT_LANGUAGE
      data.each do |key, value|
        data[key] = get_translated_value translator, value
      end
    end
    data
  end
  
  def get_translated_value(translator, value)
    if cache.is_cached(value)
      cache.get_cached_value(value)
    else
      translation = translator.translate(Linguine::DEFAULT_LANGUAGE, to_lang, value)
      cache.add(value, translation)
      translation
    end
  end

  def get_file_data(file_path)
    data = {}
    File.readlines(file_path).each do |line|
      key, value = line.split(':')
      value = value.strip
      data[key] = value
    end
    data
  end

end