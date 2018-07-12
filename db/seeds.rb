House.create!([{
	name:'Hickstead Autions', 
	address1:'Hope Place',
	address2:'Hopestead',
	postcode:'W1 1AA', 
	phone:'07867456789',
	email: 'hello@auctions.com',
	code:'HA',
	siteinfo: true}, 
	{
	name:'Electric Autions', 
	address1:'Hope Place',
	address2:'Hopestead',
	postcode:'W1 1AA', 
	phone:'07867456789',
	code:'EA',
	email: 'hello@electricals.com',
	siteinfo: false
}])

Sale.create!([{
	house_id: 1,
	date: 2.days.from_now,
	active: true,
	complete: false
},
{
	house_id: 2,
	date: 3.days.from_now,
	active: true,
	complete: false
},
{
	house_id: 1,
	date: 14.days.from_now,
	active: false,
	complete: false
}])

Buyer.create!([{
	firstname: 'Tony',
	lastname: 'Abrahams',
	email: 'tony@abrahams.com',
	phone: '07967678456',
	commrate:15,
	code: '100'
},
{
	firstname: 'George',
	lastname: 'Ross',
	email: 'georgie@ross.com',
	phone: '07953846456',
	commrate:15,
	code: '7'
},
{
	firstname: 'Louis',
	lastname: 'Oddjob',
	email: 'louis@job.com',
	phone: '07894837656',
	commrate:15,
	code: '123'
}])

Seller.create!([{
	firstname: 'Blake',
	lastname: 'Smith',
	email: 'blake@smith.com',
	phone: '07899978456',
	commrate:15,
	code: 'BS'
},
{
	firstname: 'Peter',
	lastname: 'George',
	email: 'peter@george.com',
	phone: '07958886456',
	commrate:15,
	code: 'PG'
},
{
	firstname: 'Gary',
	lastname: 'Buckle',
	email: 'gaz@buckle.com',
	phone: '07894837656',
	commrate:15,
	code: 'GB'
}])
Category.create!([{
	title: 'TV'
},
{
	title: 'Audio'
}])

Lot.create!([{
	manufacturer: 'Sony',
	model: 'xyz123',
	description:'a long and detailed blurb about the item',
	reserve: 40,
	sale_id: 1,
	lotnumber: 1,
	seller_id: 1,
	category_id: 1
},
{
	manufacturer: 'Samsung',
	model: 'abclcd4',
	description:'a long and detailed blurb about the item',
	reserve: 40,
	sale_id: 1,
	lotnumber: 2,
	seller_id: 2,
	category_id: 1
},
{
	manufacturer: 'Hitachi',
	model: 'jj47774',
	description:'a long and detailed blurb about the item',
	reserve: 40,
	sale_id: 1,
	lotnumber: 3,
	seller_id: 3,
	category_id: 1
},
{
	manufacturer: 'Samsung',
	model: 'ff9fflcd0',
	description:'a long and detailed blurb about the item',
	reserve: 40,
	sale_id: 1,
	lotnumber: 4,
	seller_id: 1,
	category_id: 1
},
{
	manufacturer: 'Technics',
	model: 'ff9fflcd0',
	description:'a long and detailed blurb about the item',
	reserve: 40,
	sale_id: 1,
	lotnumber: 5,
	seller_id: 1,
	category_id: 2
},
{
	manufacturer: 'Samsung',
	model: 'zz995',
	description:'a long and detailed blurb about the item',
	reserve: 40,
	sale_id: 1,
	lotnumber: 6,
	seller_id: 2,
	category_id: 1
},
{
	manufacturer: 'Sony',
	model: 'xyz123',
	description:'a long and detailed blurb about the item',
	reserve: 40,
	sale_id: 2,
	lotnumber: 1,
	seller_id: 1,
	category_id: 1
},
{
	manufacturer: 'Samsung',
	model: 'abclcd4',
	description:'a long and detailed blurb about the item',
	reserve: 40,
	sale_id: 2,
	lotnumber: 2,
	seller_id: 2,
	category_id: 1
},
{
	manufacturer: 'Hitachi',
	model: 'jj47774',
	description:'a long and detailed blurb about the item',
	reserve: 40,
	sale_id: 2,
	lotnumber: 3,
	seller_id: 3,
	category_id: 1
},
{
	manufacturer: 'Samsung',
	model: 'ff9fflcd0',
	description:'a long and detailed blurb about the item',
	reserve: 40,
	sale_id: 2,
	lotnumber: 4,
	seller_id: 1,
	category_id: 1
},
{
	manufacturer: 'Technics',
	model: 'ff9fflcd0',
	description:'a long and detailed blurb about the item',
	reserve: 40,
	sale_id: 2,
	lotnumber: 5,
	seller_id: 1,
	category_id: 2
},
{
	manufacturer: 'Samsung',
	model: 'zz995',
	description:'a long and detailed blurb about the item',
	reserve: 40,
	sale_id: 2,
	lotnumber: 6,
	seller_id: 2,
	category_id: 1
}])

Bid.create!([{
	buyer_id: 1,
	lot_id: 1,
	bidvalue: 100,
	sale_id: 1
},
{
	buyer_id: 2,
	lot_id: 1,
	bidvalue: 110,
	sale_id: 1
},
{
	buyer_id: 3,
	lot_id: 1,
	bidvalue: 120,
	sale_id: 1
},
{
	buyer_id: 1,
	lot_id: 2,
	bidvalue: 90,
	sale_id: 1
},
{
	buyer_id: 2,
	lot_id: 2,
	bidvalue: 95,
	sale_id: 1
},
{
	buyer_id: 3,
	lot_id: 2,
	bidvalue: 120,
	sale_id: 1
},
{
	buyer_id: 1,
	lot_id: 3,
	bidvalue: 50,
	sale_id: 1
},
{
	buyer_id: 2,
	lot_id: 3,
	bidvalue: 85,
	sale_id: 1
},
{
	buyer_id: 3,
	lot_id: 3,
	bidvalue: 95,
	sale_id: 1
},
{
	buyer_id: 1,
	lot_id: 4,
	bidvalue: 120,
	sale_id: 1
},
{
	buyer_id: 2,
	lot_id: 4,
	bidvalue: 111,
	sale_id: 1
},
{
	buyer_id: 3,
	lot_id: 4,
	bidvalue: 80,
	sale_id: 1
},
{
	buyer_id: 1,
	lot_id: 5,
	bidvalue: 60,
	sale_id: 1
},
{
	buyer_id: 2,
	lot_id: 5,
	bidvalue: 70,
	sale_id: 1
},
{
	buyer_id: 3,
	lot_id: 5,
	bidvalue: 55,
	sale_id: 1
},
{
	buyer_id: 1,
	lot_id: 7,
	bidvalue: 100,
	sale_id: 2
},
{
	buyer_id: 2,
	lot_id: 7,
	bidvalue: 110,
	sale_id: 2
},
{
	buyer_id: 3,
	lot_id: 7,
	bidvalue: 120,
	sale_id: 2
},
{
	buyer_id: 1,
	lot_id: 8,
	bidvalue: 90,
	sale_id: 2
},
{
	buyer_id: 2,
	lot_id: 8,
	bidvalue: 95,
	sale_id: 2
},
{
	buyer_id: 3,
	lot_id: 8,
	bidvalue: 120,
	sale_id: 2
},
{
	buyer_id: 1,
	lot_id: 9,
	bidvalue: 50,
	sale_id: 2
},
{
	buyer_id: 2,
	lot_id: 9,
	bidvalue: 85,
	sale_id: 2
},
{
	buyer_id: 3,
	lot_id: 9,
	bidvalue: 95,
	sale_id: 2
},
{
	buyer_id: 1,
	lot_id: 9,
	bidvalue: 120,
	sale_id: 2
},
{
	buyer_id: 2,
	lot_id: 9,
	bidvalue: 111,
	sale_id: 2
},
{
	buyer_id: 3,
	lot_id: 10,
	bidvalue: 80,
	sale_id: 2
},
{
	buyer_id: 1,
	lot_id: 10,
	bidvalue: 60,
	sale_id: 2
},
{
	buyer_id: 2,
	lot_id: 11,
	bidvalue: 70,
	sale_id: 2
},
{
	buyer_id: 3,
	lot_id: 12,
	bidvalue: 55,
	sale_id: 2
}])
