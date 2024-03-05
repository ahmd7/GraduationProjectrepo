CREATE USER IF NOT EXISTS 'catalogue_user' IDENTIFIED BY 'default_password';

GRANT ALL ON socksdb.* TO 'catalogue_user';

CREATE TABLE IF NOT EXISTS sock (
	sock_id varchar(40) NOT NULL, 
	name varchar(20), 
	description varchar(500), 
	price float, 
	count int, 
	image_url_1 varchar(40), 
	image_url_2 varchar(40), 
	PRIMARY KEY(sock_id)
);

CREATE TABLE IF NOT EXISTS tag (
	tag_id MEDIUMINT NOT NULL AUTO_INCREMENT, 
	name varchar(20), 
	PRIMARY KEY(tag_id)
);

CREATE TABLE IF NOT EXISTS sock_tag (
	sock_id varchar(40), 
	tag_id MEDIUMINT NOT NULL, 
	FOREIGN KEY (sock_id) 
		REFERENCES sock(sock_id), 
	FOREIGN KEY(tag_id)
		REFERENCES tag(tag_id)
);

INSERT INTO sock VALUES ("6d62d909-f957-430e-8689-b5129c0bb75e", "American Eagle Dress", "Since 1977, American Eagle has offered an assortment of specialty apparel and accessories for men and women that enables self-expression and empowers our customers to celebrate their individuality. The brand has broadened its leadership in jeans by producing innovative fabric with options for all styles and fits for all at a value. We are not just passionate about making great clothing, we are passionate about making real connections with the people who wear them.", 110.00, 12, "/catalogue/images/dress1.jpg", "/catalogue/images/dress2.jpg");
INSERT INTO sock VALUES ("a0a4f044-b040-410d-8ead-4de0446aec7e", "Tricot  Cardigan", "Founded in 2003, DEFACTO is today one of the most popular fashion brands in Turkey and around the world with more than 500 stores. It is positioned as a pioneering brand of fashion throughout the Mediterranean world.", 40.00, 10, "/catalogue/images/cardi1.jpg", "/catalogue/images/cardi2.jpg");
INSERT INTO sock VALUES ("808a2de1-1aaa-4c25-a9b9-6612e8f29a38", "Kady Plain Slip ", "This Brand Offers Good Materials & Easy Home Wear For Women. It is the best brand anyone could wish to have their products.", 17.00, 15, "/catalogue/images/cardii1.jpg", "/catalogue/images/cardii2.jpeg");
INSERT INTO sock VALUES ("510a0d7e-8e83-4193-b483-e27e09ddc34d", "Andora Hoodie", "Andora fashion store for men and women offer a wide range of clothing, They may have various categories such as tops, bottoms, dresses, suits, and more.",  20.00, 8, "/catalogue/images/kid1.jpg", "/catalogue/images/kid2.jpg");
INSERT INTO sock VALUES ("03fef6ac-1896-4ce8-bd69-b798f85c6e0b", "Andora  Boys Jacket", "Andora fashion store for men and women offer a wide range of clothing, They may have various categories such as tops, bottoms, dresses, suits, and more.",  45.00, 5, "/catalogue/images/kidd1.jpg", "/catalogue/images/kidd2.jpg");
INSERT INTO sock VALUES ("d3588630-ad8e-49df-bbd7-3167f7efb246", "Caesar Training Suit ", "You can shop for anything you need from our store with a very affordable prices and best materials and it is a really easy way tofind good quality products you can check out our store.",  30.00, 7, "/catalogue/images/kids1.jpg", "/catalogue/images/kids2.jpg");
INSERT INTO sock VALUES ("819e1fbf-8b7e-4f6d-811f-693534916a8b", "Black Fashion Jacket", "The black fashion jacket exudes timeless sophistication with its sleek silhouette and classic color. Versatile for both formal and casual occasions, it features refined details like lapels and pockets, elevating any outfit effortlessly.",  52.00, 8, "/catalogue/images/jacket1.jpg", "/catalogue/images/jacket2.jpg");
INSERT INTO sock VALUES ("zzz4f044-b040-410d-8ead-4de0446aec7e", "Short Sleeve T-Shirt", "The Short Sleeve T-Shirt is a casual essential, perfect for everyday wear. Crafted from soft and breathable fabrics, it offers comfort and ease of movement. With its classic design and variety of colors and patterns, the Short Sleeve T-Shirt effortlessly adds a touch of laid-back style to any wardrobe.",  35.00, 20, "/catalogue/images/T1.jpg", "/catalogue/images/T2.jpg");
INSERT INTO sock VALUES ("3395a43e-2d88-40de-b95f-e00e1502085b", "Caesar Women  Hoodie ", "You can shop for anything you need from our store with a very affordable prices and best materials and it is a really easy way to find good quality products you can check out our store on Jumia",  30.00, 9, "/catalogue/images/Hodie1.jpg", "/catalogue/images/Hodie2.jpg");
INSERT INTO sock VALUES ("837ab141-399e-4c1f-9abc-bace40296bac", "Printed Hoodie ", "In our store  we offer a variety clothes which suits all tastes and ages made from finest and highest materials at competitive prices we use a high materials for printing and amodern designs which suits all ages",  20.00, 15, "/catalogue/images/ph1.jpg", "/catalogue/images/ph2.jpg");

INSERT INTO tag (name) VALUES ("Men");
INSERT INTO tag (name) VALUES ("Women");
INSERT INTO tag (name) VALUES ("Kids");
INSERT INTO tag (name) VALUES ("Fashion");
INSERT INTO tag (name) VALUES ("Pink");
INSERT INTO tag (name) VALUES ("Black");
INSERT INTO tag (name) VALUES ("Jacket");
INSERT INTO tag (name) VALUES ("T-shirt");
INSERT INTO tag (name) VALUES ("Red");
INSERT INTO tag (name) VALUES ("Casual");
INSERT INTO tag (name) VALUES ("Orange");

INSERT INTO sock_tag VALUES ("6d62d909-f957-430e-8689-b5129c0bb75e", "2");
INSERT INTO sock_tag VALUES ("6d62d909-f957-430e-8689-b5129c0bb75e", "4");
INSERT INTO sock_tag VALUES ("6d62d909-f957-430e-8689-b5129c0bb75e", "6");
INSERT INTO sock_tag VALUES ("a0a4f044-b040-410d-8ead-4de0446aec7e", "2");
INSERT INTO sock_tag VALUES ("a0a4f044-b040-410d-8ead-4de0446aec7e", "6");
INSERT INTO sock_tag VALUES ("808a2de1-1aaa-4c25-a9b9-6612e8f29a38", "2");
INSERT INTO sock_tag VALUES ("808a2de1-1aaa-4c25-a9b9-6612e8f29a38", "4");
INSERT INTO sock_tag VALUES ("808a2de1-1aaa-4c25-a9b9-6612e8f29a38", "9");
INSERT INTO sock_tag VALUES ("510a0d7e-8e83-4193-b483-e27e09ddc34d", "3");
INSERT INTO sock_tag VALUES ("510a0d7e-8e83-4193-b483-e27e09ddc34d", "5");
INSERT INTO sock_tag VALUES ("510a0d7e-8e83-4193-b483-e27e09ddc34d", "7");
INSERT INTO sock_tag VALUES ("03fef6ac-1896-4ce8-bd69-b798f85c6e0b", "3");
INSERT INTO sock_tag VALUES ("03fef6ac-1896-4ce8-bd69-b798f85c6e0b", "7");
INSERT INTO sock_tag VALUES ("03fef6ac-1896-4ce8-bd69-b798f85c6e0b", "6");
INSERT INTO sock_tag VALUES ("d3588630-ad8e-49df-bbd7-3167f7efb246", "3");
INSERT INTO sock_tag VALUES ("d3588630-ad8e-49df-bbd7-3167f7efb246", "9");
INSERT INTO sock_tag VALUES ("d3588630-ad8e-49df-bbd7-3167f7efb246", "7");
INSERT INTO sock_tag VALUES ("819e1fbf-8b7e-4f6d-811f-693534916a8b", "1");
INSERT INTO sock_tag VALUES ("819e1fbf-8b7e-4f6d-811f-693534916a8b", "7");
INSERT INTO sock_tag VALUES ("819e1fbf-8b7e-4f6d-811f-693534916a8b", "6");
INSERT INTO sock_tag VALUES ("zzz4f044-b040-410d-8ead-4de0446aec7e", "1");
INSERT INTO sock_tag VALUES ("zzz4f044-b040-410d-8ead-4de0446aec7e", "8");
INSERT INTO sock_tag VALUES ("zzz4f044-b040-410d-8ead-4de0446aec7e", "10");
INSERT INTO sock_tag VALUES ("3395a43e-2d88-40de-b95f-e00e1502085b", "2");
INSERT INTO sock_tag VALUES ("3395a43e-2d88-40de-b95f-e00e1502085b", "5");
INSERT INTO sock_tag VALUES ("837ab141-399e-4c1f-9abc-bace40296bac", "2");
INSERT INTO sock_tag VALUES ("837ab141-399e-4c1f-9abc-bace40296bac", "10");
INSERT INTO sock_tag VALUES ("837ab141-399e-4c1f-9abc-bace40296bac", "11");




