require 'open-uri'
require 'json'



url = `https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&input=music%rehearsal%venues&inputtype=textquery&key=AIzaSyBhvbimgkK3MN2tHSRtpXDkLFYq91kmQHk`

response = URI.open(url).read
puts response
