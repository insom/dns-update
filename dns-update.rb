require 'dnsruby'
require 'net/http'
require 'json'
 
url = 'http://jsonip.com/'
key_name = 'keyname'
key = 'keygoeshere='

uri = URI(url)
response = Net::HTTP.get(uri)
j = JSON.parse(response)

update = Dnsruby::Update.new('insm.cf')
update.delete('home.insm.cf.', 'A')
update.add('home.insm.cf.', 'A', 300, j['ip'])

res = Dnsruby::Resolver.new({:nameserver => 'rho.insom.me.uk'})

tsig = Dnsruby::RR::TSIG.new
tsig.algorithm= Dnsruby::RR::TSIG::HMAC_SHA256
tsig.key= key
tsig.name= key_name
res.tsig= tsig

res.send_message(update)
