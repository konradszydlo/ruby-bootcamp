require_relative '../main'

describe Linguine do


  let(:env) { {'PATH_INFO' => '/home.fr', 'REQUEST_METHOD' => 'GET'} }

  let(:home_data) { ["welcome:Hi\n", "first_para:Our company is based in Leeds.\n", "second_para:We specialise in doing funny things.\n", "third_para:Our company is based in Leeds."] }

  let(:content) { {"welcome"=>"hallo", "first_para"=>"Unser Unternehmen ist in Leeds .", "second_para"=>"Wir spezialisieren uns auf lustige Dinge zu tun .", "third_para"=>"Unser Unternehmen ist in Leeds ."} }

  let(:body_our_company) { %Q{[[["notre société est à Leeds","our company is in Leeds"]],,"en",,,[["our company is",1,[["notre société est",442,true,false],["notre entreprise est",199,true,false],["notre compagnie est",0,true,false],["notre entreprise",0,true,false]],[[0,14]],"our company is in Leeds",0,3],["in Leeds",2,[["à Leeds",619,true,false],["Leeds",0,true,false],["de Leeds",0,true,false]],[[15,23]],,3,5]],0.15957327,,[["en"],,[0.15957327]]]} }

  let(:body_hi) { %Q{[[["salut","Hi"]],,"en",,,[["Hi",1,[["salut",1000,true,false]],[[0,2]],"Hi",0,1]],,,,,,,,,[["Hi!","HI","hi"]]]} }

  let(:body_we_specialise) { %Q{[[["Nous nous spécialisons dans faire des choses drôles .","We specialise in doing funny things."]],,"en",,,[["We specialize in",1,[["Nous nous spécialisons dans",999,true,false],["Nous sommes spécialistes de",0,true,false],["Nous sommes spécialistes",0,true,false],["Nous sommes spécialisés dans",0,true,false],["Nous nous spécialisons en",0,true,false]],[[0,16]],"We specialise in doing funny things.",0,4],["doing things",2,[["faire des choses",995,true,false],["faire les choses",0,true,false],["faisant des choses",0,true,false],["à faire des choses",0,true,false],["de faire les choses",0,true,false]],[[17,22],[29,35]],,4,7],["funny",3,[["drôles",910,true,false],["drôle",0,true,false],["funny",0,true,false],["drôles de",0,true,false],["amusantes",0,true,false]],[[23,28]],,7,8],[".",4,[[".",914,false,false]],[[35,36]],,8,9]],0.2650139,,[["en"],,[0.2650139]]]} }

  let(:template) { %Q{<!DOCTYPE>
<html>
<head>
    <meta charset="utf-8">
</head>
<body>
<h1><%= content['welcome'] %> ERB</h1>
<p><%= content['first_para'] %></p>
<p><%= content['second_para'] %></p>
<p><%= content['third_para'] %></p>
</body>
</html>
}}

  let(:result) { [200, {}, ["<!DOCTYPE>\n<html>\n<head>\n    <meta charset=\"utf-8\">\n</head>\n<body>\n<h1>salut ERB</h1>\n<p>notre société est à Leeds</p>\n<p>Nous nous spécialisons dans faire des choses drôles .</p>\n<p>notre société est à Leeds</p>\n</body>\n</html>\n"]] }

  describe '#call' do
    before :each do
      stub_request(:get, "https://translate.google.com/translate_a/single?client=t&dt=sw&hl=en&ie=UTF-8&oe=UTF-8&prev=btn&q=Our%20company%20is%20based%20in%20Leeds.&rom=1&sl=en&ssel=0&tl=fr&tsel=0").
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded; charset=UTF-8', 'User-Agent'=>'Ruby/2.2.1'}).
          to_return(:status => 200, :body => body_our_company, :headers => {})

      stub_request(:get, "https://translate.google.com/translate_a/single?client=t&dt=sw&hl=en&ie=UTF-8&oe=UTF-8&prev=btn&q=Hi&rom=1&sl=en&ssel=0&tl=fr&tsel=0").
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded; charset=UTF-8', 'User-Agent'=>'Ruby/2.2.1'}).
          to_return(:status => 200, :body => body_hi, :headers => {})

      stub_request(:get, "https://translate.google.com/translate_a/single?client=t&dt=sw&hl=en&ie=UTF-8&oe=UTF-8&prev=btn&q=We%20specialise%20in%20doing%20funny%20things.&rom=1&sl=en&ssel=0&tl=fr&tsel=0").
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded; charset=UTF-8', 'User-Agent'=>'Ruby/2.2.1'}).
          to_return(:status => 200, :body => body_we_specialise, :headers => {})
    end

    it 'returns response' do
      expect(File).to receive(:readlines).and_return(home_data)
      expect(File).to receive(:read).and_return(template)

      expect(subject.call(env)).to eq(result)
    end
  end
end