# require 'faker'
# include Faker

# running this seed file will take some time
# it will generate buyers and sellers
# numberofsales auctions
# numberofsales * numberoflots lots
# numberofsales * numberoflots * 15 bids
# modify the variables in the file to generate to relevant amount of seed data
# depending on your time and space
# 10% of the auctions will active, 90% complete
# ensure numberofsales / 10 != 0


Auctioneer.create!(
	name: 'Ian',
	email: 'ian@s33d.co',
	phone: '07968799929'
)

# Buyer.create(
# 	firstname: 		Faker::Name.first_name,
# 	lastname: 		Faker::Name.last_name ,
# 	email: 				'ian@s33d.co',
# 	phone: 				Faker::PhoneNumber.phone_number,
# 	commrate: 		rand(7..20),
# 	code: 				rand(100..999),
# 	password: 		'password')

# Seller.create(
# 	firstname: 		Faker::Name.first_name,
# 	lastname: 		Faker::Name.last_name ,
# 	email: 				'imarley@warpmail.net',
# 	phone: 				Faker::PhoneNumber.phone_number,
# 	commrate: 		rand(7..20),
# 	code: 				rand(100..999),
# 	password: 'password')

# numberofhouses = 3
# numberofbuyers = 5
# numberofsellers = 5
# numberofsales = 10 #must be divisable by 10
# averagebidsperlot = 5




	# House.create!(
	# 	name: 			'Exsale Auctions',  
	# 	phone: 			'07853381333',
	# 	email: 			Faker::Internet.email,
	# 	siteinfo: 	true)


# puts "#{House.count} houses created"

# make 7 product categories
# Category.create!([
# 	{title: 'TV'},
# 	{title: 'Digital'},
# 	{title: 'Home Cinema'},
# 	{title: 'Tower PCs'},
# 	{title: 'Laptops'},
# 	{title: 'Phones'},
# 	{title: 'Audio'}
# 	])

# puts "#{Category.count} catergories created"

# make buyers

# numberofbuyers.times do
# 	Buyer.create!(
# 		firstname: 		Faker::Name.first_name,
# 		lastname: 		Faker::Name.last_name ,
# 		email: 				Faker::Internet.email,
# 		phone: 				Faker::PhoneNumber.phone_number,
# 		commrate: 		rand(7..20),
# 		code: 				rand(100..999),
# 		password:   	('A'..'Z').to_a.shuffle[0,12].join)
# end

# puts "#{Buyer.count} buyers created"

# make sellers

# numberofsellers.times do
# Seller.create!(
# 		firstname: 		Faker::Name.first_name,
# 		lastname: 		Faker::Name.last_name ,
# 		email: 				Faker::Internet.email,
# 		phone: 				Faker::PhoneNumber.phone_number,
# 		commrate: 		rand(7..20),
# 		code: 				('A'..'Z').to_a.shuffle[0,2].join,
# 		password:   	('A'..'Z').to_a.shuffle[0,12].join)
# end


# puts "#{Seller.count} sellers created"

# make x active sales with 120 lots in each
# change numbersales variable to reduce or increase seed date
# depending on space and time, minimum value is 10


# numberofsales.times do
# 	auction = Sale.create!(
# 		house_id: 		rand(1..House.all.count),
# 		date: 				numberofsales.days.ago,
# 		active: 			true,
# 		complete: 		false,
# 		notch: 				rand(1..5),
# 		minfee: 			rand(0.99..9.99)
# 												)
# 		numberofsales -= 1
# 		lotnumber = 1
# 		numberoflots = 10
# 		numberoflots.times do
# 			lot = auction.lots.new
# 			lot.update!(
# 			manufacturer: Faker::Device.manufacturer,
# 			model: 				Faker::Device.model_name,
# 			description: 	Faker::Hipster.paragraph(5, true, 2),
# 			reserve: 			rand(5..120),
# 			seller_id: 		rand(1..Seller.all.count),
# 			category_id: 	rand(1..Category.all.count),
# 			lotnumber: 		lotnumber
# 									)
# 			lotnumber += 1
# 	end
# end

# puts "#{Sale.count} sales with #{Lot.count} lots created"


# # make an average of x bids per lot

# numberofbids = ( Lot.all.count * averagebidsperlot)



# numberofbids.times do
# 	begin
# 			Bid.create!(
# 				buyer_id: 		rand(1..Buyer.all.count),
# 				lot_id: 			rand(1..Lot.all.count),
# 				bidvalue: 		rand(5..120), # this could create some unsold lots reserve & bid max the same value
# 				sale_id: 			rand(1..Sale.all.count)
# 									)
# 	rescue ActiveRecord::RecordInvalid
# 		puts "bid skipped value too low #{Bid.count} bids in table"
# 		puts '.'
# 	end
# end

# puts "#{Bid.count} bids created"

# 20.times do
# 	puts '.'
# 	puts ' '
# end
# puts "#{House.count} houses,"
# puts "#{Category.count} catergories,"
# puts "#{Buyer.count} buyers,"
# puts "#{Seller.count} sellers,"
# puts "#{Sale.count} sales," 
# puts "#{Lot.count} lots," 
# puts "#{Bid.count} bids in the database...."
# puts "generating reports"

# # make most recent 10% of auctions active
# howmanycomplete = ((Sale.all.count / 10) * 9)



# # order the auctions by date and set the earlier 25 to complete with buyer an sellers both paid
# auctions = Sale.order(date: :asc).limit(howmanycomplete)
# auctions.each do | a |
# 	a.update(active:false, complete:true)
# 	a.lots.each do | lot |
# 		if lot.reserve > lot.highest_bid_value
# 		  lot.update_attributes(sold: false, soldat: 0, bfee:0, sfee:0) # not setting buyer/sellerpaid to true as these attributes decide lot populating on show page of relevant nodel
#     else
#       lot.update_attributes(soldat:lot.selling_price, bfee:lot.buyingfee, sfee:lot.sellingfee, sold: true, buyerpaid:true, sellerpaid:true, buyer_id:lot.highest_bid.first.buyer_id) #buyerpaid / sellerpaid are updated to false in the app, true here so these completed lots are seen as fully paid out / in
#       lot.highest_bid.first.update(won: true)
#     end
# 	end
# end


# puts "complete ;-)"


