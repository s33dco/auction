House.create!({
	name:'Hickstead Autions', 
	address1:'Hope Place',
	address2:'Hickstead',
	postcode:'W1 1AA', 
	phone:'07867456789',
	email: 'hello@hicksteadauctions.com',
								})
Sale.create!({
	house_id: 1,
	date: 14.days.ago
})
Buyer.create!([{
	firstname: 'Tony',
	lastname: 'Abrahams',
	email: 'tony@abrahams.com',
	phone: '07967678456',
	commrate:15
},
{
	firstname: 'George',
	lastname: 'Ross',
	email: 'georgie@ross.com',
	phone: '07953846456',
	commrate:15
},
{
	firstname: 'Louis',
	lastname: 'Oddjob',
	email: 'louis@job.com',
	phone: '07894837656',
	commrate:15
}])

Seller.create!([{
	firstname: 'Blake',
	lastname: 'Smith',
	email: 'blake@smith.com',
	phone: '07899978456',
	commrate:15
},
{
	firstname: 'Peter',
	lastname: 'George',
	email: 'peter@george.com',
	phone: '07958886456',
	commrate:15
},
{
	firstname: 'Gary',
	lastname: 'Buckle',
	email: 'gaz@buckle.com',
	phone: '07894837656',
	commrate:15
}])
Category.create!([{
	title: 'Televisions'
},
{
	title: 'Audio'
}])
Lot.create!([{
	manufacturer: 'Sony',
	model: 'xyz123',
	description:'a long and detailed blurb about the item',
	reserve: 100,
	sale_id: 1,
	lotnumber: 1,
	seller_id: 1,
	category_id: 1
},
{
	manufacturer: 'Samsung',
	model: 'abclcd4',
	description:'a long and detailed blurb about the item',
	reserve: 90,
	sale_id: 1,
	lotnumber: 2,
	seller_id: 2,
	category_id: 1
},
{
	manufacturer: 'Hitachi',
	model: 'jj47774',
	description:'a long and detailed blurb about the item',
	reserve: 60,
	sale_id: 1,
	lotnumber: 3,
	seller_id: 3,
	category_id: 1
},
{
	manufacturer: 'Samsung',
	model: 'ff9fflcd0',
	description:'a long and detailed blurb about the item',
	reserve: 90,
	sale_id: 1,
	lotnumber: 4,
	seller_id: 1,
	category_id: 1
},
{
	manufacturer: 'Samsung',
	model: 'zz995',
	description:'a long and detailed blurb about the item',
	reserve: 90,
	sale_id: 1,
	lotnumber: 5,
	seller_id: 2,
	category_id: 1
}])
Bid.create!([{
	buyer_id: 1,
	lot_id: 1,
	bidvalue: 100
},
{
	buyer_id: 2,
	lot_id: 1,
	bidvalue: 110
},
{
	buyer_id: 3,
	lot_id: 1,
	bidvalue: 120
},
{
	buyer_id: 1,
	lot_id: 2,
	bidvalue: 90
},
{
	buyer_id: 2,
	lot_id: 2,
	bidvalue: 95
},
{
	buyer_id: 3,
	lot_id: 2,
	bidvalue: 120
},
{
	buyer_id: 1,
	lot_id: 3,
	bidvalue: 50
},
{
	buyer_id: 2,
	lot_id: 3,
	bidvalue: 85
},
{
	buyer_id: 3,
	lot_id: 3,
	bidvalue: 95
},
{
	buyer_id: 1,
	lot_id: 4,
	bidvalue: 120
},
{
	buyer_id: 2,
	lot_id: 4,
	bidvalue: 111
},
{
	buyer_id: 3,
	lot_id: 4,
	bidvalue: 80
},
{
	buyer_id: 1,
	lot_id: 5,
	bidvalue: 60
},
{
	buyer_id: 2,
	lot_id: 5,
	bidvalue: 70
},
{
	buyer_id: 3,
	lot_id: 5,
	bidvalue: 55
}])

