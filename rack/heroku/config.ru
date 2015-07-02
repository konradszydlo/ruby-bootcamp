
use Rack::Static,
    :urls => ['/images', '/js', '/css'],
    :root => 'public'

# app =  Proc.new do |env|
app = lambda do |env|
    [200,
     { 'Content-Type' => 'text/html', 'Cache-Control' => 'public, max-age=86400'},
     File.open('public/index.html', File::RDONLY)]
end

run app

