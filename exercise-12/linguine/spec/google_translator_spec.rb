require_relative '../google_translator'

describe GoogleTranslator do

  describe '#translate' do

    body = %Q{[[["notre société est à Leeds","our company is in Leeds"]],,"en",,,[["our company is",1,[["notre société est",442,true,false],["notre entreprise est",199,true,false],["notre compagnie est",0,true,false],["notre entreprise",0,true,false]],[[0,14]],"our company is in Leeds",0,3],["in Leeds",2,[["à Leeds",619,true,false],["Leeds",0,true,false],["de Leeds",0,true,false]],[[15,23]],,3,5]],0.15957327,,[["en"],,[0.15957327]]]}

    before :each do
      stub_request(:get, "https://translate.google.com/translate_a/single?client=t&dt=sw&hl=en&ie=UTF-8&oe=UTF-8&prev=btn&q=Our%20company%20is%20in%20Leeds&rom=1&sl=en&ssel=0&tl=fr&tsel=0").
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded; charset=UTF-8', 'User-Agent'=>'Ruby/2.2.1'}).

          to_return(:status => 200, :body => body, :headers => {})

    end

    context 'from English to French' do
      it 'returns translated data' do
        expect(subject.translate('en', 'fr', 'Our company is in Leeds').size).to be > 0
      end
      it 'translates from english to french' do
        expect(subject.translate('en', 'fr', 'Our company is in Leeds')).to eq("notre société est à Leeds")
      end
    end

  end
end