require 'faker'
include Faker

# running this seed file will take some time
# it will generate buyers and sellers
# numberofsales auctions
# numberofsales * numberoflots lots
# numberofsales * numberoflots * 15 bids
# modify the variables in the file to generate to relevant amount of seed data
# depending on your time and space
# 10% of the auctions will active, 90% complete
# ensure numberofsales / 10 != 0


# make five auction houses
5.times do
	House.create!(
		name: 			Faker::Company.unique.name, 
		address1: 	Faker::Address.street_address,
		address2: 	Faker::Address.city,
		postcode: 	Faker::Address.postcode, 
		phone: 			Faker::PhoneNumber.phone_number,
		email: 			Faker::Internet.email,
		code: 			('A'..'Z').to_a.shuffle[0,2].join,
		siteinfo: 	false)
end

# make 7 product categories
Category.create!([
	{title: 'TV'},
	{title: 'Digital'},
	{title: 'Home Cinema'},
	{title: 'Tower PCs'},
	{title: 'Laptops'},
	{title: 'Phones'},
	{title: 'Audio'}
	])

# make buyers
60.times do
	Buyer.create!(
		firstname: 		Faker::Name.first_name,
		lastname: 		Faker::Name.unique.last_name ,
		email: 				Faker::Internet.unique.email,
		phone: 				Faker::PhoneNumber.phone_number,
		commrate: 		rand(7..20),
		code: 				rand(100..999))
end

# make sellers
25.times do
Seller.create!(
		firstname: 		Faker::Name.first_name,
		lastname: 		Faker::Name.unique.last_name ,
		email: 				Faker::Internet.unique.email,
		phone: 				Faker::PhoneNumber.phone_number,
		commrate: 		rand(7..20),
		code: 				('A'..'Z').to_a.shuffle[0,2].join)
end

# make x active sales with 120 lots in each
# change numbersales variable to reduce or increase seed date
# depending on space and time, minimum value is 10

numberofsales = 60
numberofsales.times do
	auction = Sale.create!(
		house_id: 		rand(1..House.all.count),
		date: 				numberofsales.days.ago,
		active: 			true,
		complete: 		false,
		notch: 				rand(1..5),
		minfee: 			rand(0.99..9.99)
												)
		numberofsales -= 1
		lotnumber = 1
		numberoflots = 150
		numberoflots.times do
			lot = auction.lots.new
			lot.update!(
			manufacturer: Faker::Device.manufacturer,
			model: 				Faker::Device.model_name,
			description: 	Faker::Hipster.paragraph(5, true, 2),
			reserve: 			rand(5..200),
			seller_id: 		rand(1..Seller.all.count),
			category_id: 	rand(1..Category.all.count),
			lotnumber: 		lotnumber
									)
			lotnumber += 1
	end
end

# make an average of x bids per lot
x = 10
numberofbids = ( Lot.all.count * x)
numberofbids.times do
	Bid.create!(
		buyer_id: 		rand(1..Buyer.all.count),
		lot_id: 			rand(1..Lot.all.count),
		bidvalue: 		rand(5..200), # this could create some unsold lots reserve & bid max the same value
		sale_id: 			rand(1..Sale.all.count)
							)
end

# make most recent 10% of auctions active
howmanycomplete = ((Sale.all.count / 10) * 9)

# order the auctions by date and set the earlier 25 to complete with buyer an sellers both paid
auctions = Sale.order(date: :asc).limit(howmanycomplete)
auctions.each do | a |
	a.update(active:false, complete:true)
	a.lots.each do | lot |
		if lot.reserve > lot.highest_bid_value
		  lot.update_attributes(sold: false, soldat: 0, bfee:0, sfee:0) # not setting buyer/sellerpaid to true as these attributes decide lot populating on show page of relevant nodel
    else
      lot.update_attributes(soldat:lot.selling_price, bfee:lot.buyingfee, sfee:lot.sellingfee, sold: true, buyerpaid:true, sellerpaid:true) #buyerpaid / sellerpaid are updated to false in the app, true here so these completed lots are seen as fully paid out / in
      lot.highest_bid.first.update(won: true)
    end
	end
end


