require 'google_translate'
require 'google_translate/result_parser'

class GoogleTranslator

  def translate(from_lang, to_lang, text)
    translator = GoogleTranslate.new

    result = translator.translate( from_lang, to_lang, text)

    parser = ResultParser.new result

    parser.translation
  end
end