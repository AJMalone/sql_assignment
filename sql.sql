/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for mydb
CREATE DATABASE IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mydb`;


-- Dumping structure for table mydb.category
CREATE TABLE IF NOT EXISTS `category` (
  `idcategory` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`idcategory`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Dumping data for table mydb.category: ~6 rows (approximately)
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`idcategory`, `category_name`) VALUES
	(1, 'Books'),
	(2, 'Clothes'),
	(3, 'Sweets'),
	(4, 'Drinks'),
	(5, 'Bakery'),
	(6, 'Fruit');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;


-- Dumping structure for table mydb.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `cust_id` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `address_1` varchar(45) NOT NULL,
  `address_2` varchar(45) NOT NULL,
  `postcode` varchar(45) NOT NULL,
  `tel` varchar(50) NOT NULL,
  `routes_route_id` int(11) NOT NULL,
  PRIMARY KEY (`cust_id`,`routes_route_id`),
  KEY `fk_customers_routes1_idx` (`routes_route_id`),
  CONSTRAINT `fk_customers_routes1` FOREIGN KEY (`routes_route_id`) REFERENCES `routes` (`route_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mydb.customers: ~5 rows (approximately)
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` (`cust_id`, `Name`, `address_1`, `address_2`, `postcode`, `tel`, `routes_route_id`) VALUES
	(1, 'John Doe', '333 Main Street', 'Poppy Estate', 'HU1 111', '111111', 1),
	(2, 'Jane Doe', '123 Fake Street', 'Rose Hills', 'HU2 222', '222222', 1),
	(3, 'Max Max', '321 High Street', 'Tulip Way', 'HU3 333', '333333', 3),
	(4, 'Jane Lane', '111 Long Street', 'Sun Lane', 'HU2 123', '444444', 2),
	(5, 'John Long', '212 Short Street', 'Blue Way', 'HU3 456', '555555', 3);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;


-- Dumping structure for table mydb.deliveries
CREATE TABLE IF NOT EXISTS `deliveries` (
  `vans_van_id` int(11) NOT NULL,
  `orders_order_id` int(11) NOT NULL,
  `orders_customers_cust_id` int(11) NOT NULL,
  `time` varchar(50) NOT NULL,
  PRIMARY KEY (`vans_van_id`,`orders_order_id`,`orders_customers_cust_id`),
  KEY `fk_vans_has_orders_orders1_idx` (`orders_order_id`,`orders_customers_cust_id`),
  KEY `fk_vans_has_orders_vans1_idx` (`vans_van_id`),
  CONSTRAINT `fk_vans_has_orders_orders1` FOREIGN KEY (`orders_order_id`, `orders_customers_cust_id`) REFERENCES `orders` (`order_id`, `customers_cust_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vans_has_orders_vans1` FOREIGN KEY (`vans_van_id`) REFERENCES `vans` (`van_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mydb.deliveries: ~2 rows (approximately)
/*!40000 ALTER TABLE `deliveries` DISABLE KEYS */;
INSERT INTO `deliveries` (`vans_van_id`, `orders_order_id`, `orders_customers_cust_id`, `time`) VALUES
	(1, 2, 1, '1500'),
	(4, 2, 4, '1700');
/*!40000 ALTER TABLE `deliveries` ENABLE KEYS */;


-- Dumping structure for table mydb.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` int(11) NOT NULL,
  `customers_cust_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`,`customers_cust_id`),
  KEY `fk_orders_customers1_idx` (`customers_cust_id`),
  CONSTRAINT `fk_orders_customers1` FOREIGN KEY (`customers_cust_id`) REFERENCES `customers` (`cust_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mydb.orders: ~4 rows (approximately)
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`order_id`, `customers_cust_id`) VALUES
	(5, 0),
	(3, 1),
	(7, 1),
	(1, 2),
	(6, 2),
	(8, 3),
	(2, 4),
	(4, 4),
	(9, 4);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;


-- Dumping structure for table mydb.orders_has_product
CREATE TABLE IF NOT EXISTS `orders_has_product` (
  `orders_order_id` int(11) NOT NULL,
  `product_product_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`orders_order_id`,`product_product_id`),
  KEY `fk_orders_has_product_product1_idx` (`product_product_id`),
  KEY `fk_orders_has_product_orders1_idx` (`orders_order_id`),
  CONSTRAINT `fk_orders_has_product_orders1` FOREIGN KEY (`orders_order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_has_product_product1` FOREIGN KEY (`product_product_id`) REFERENCES `product` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mydb.orders_has_product: ~3 rows (approximately)
/*!40000 ALTER TABLE `orders_has_product` DISABLE KEYS */;
INSERT INTO `orders_has_product` (`orders_order_id`, `product_product_id`, `quantity`) VALUES
	(1, 1, 3),
	(2, 2, 1),
	(3, 3, 2),
	(4, 10, 7),
	(5, 11, 2),
	(6, 10, 1),
	(6, 12, 3),
	(7, 5, 5),
	(7, 15, 1);
/*!40000 ALTER TABLE `orders_has_product` ENABLE KEYS */;


-- Dumping structure for table mydb.product
CREATE TABLE IF NOT EXISTS `product` (
  `product_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `product_name` varchar(45) NOT NULL,
  `supplier_supplier_id` int(11) NOT NULL,
  `category_idcategory` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`supplier_supplier_id`,`category_idcategory`),
  KEY `fk_product_supplier1_idx` (`supplier_supplier_id`),
  KEY `fk_product_category1_idx` (`category_idcategory`),
  CONSTRAINT `fk_product_category1` FOREIGN KEY (`category_idcategory`) REFERENCES `category` (`idcategory`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_supplier1` FOREIGN KEY (`supplier_supplier_id`) REFERENCES `supplier` (`supplier_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mydb.product: ~6 rows (approximately)
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`product_id`, `store_id`, `product_name`, `supplier_supplier_id`, `category_idcategory`) VALUES
	(1, 1, 'Harry Potter', 2, 1),
	(2, 2, 'Size 6 Shoes', 1, 2),
	(3, 1, 'Tiger Bread Loaf', 3, 5),
	(4, 3, 'Gloves', 1, 2),
	(5, 1, 'Mens Hat', 3, 2),
	(6, 2, 'Mens Scarf', 2, 2),
	(7, 3, 'Size 8 Shoes', 4, 2),
	(8, 1, 'Swiss Roll', 1, 5),
	(9, 3, 'The Bible', 3, 1),
	(10, 1, 'Cola', 5, 4),
	(11, 2, 'Lemonade', 2, 4),
	(12, 2, 'Loaf of Bread', 3, 5),
	(13, 3, 'Doughnuts', 1, 5),
	(14, 1, 'Womens Bra', 4, 2),
	(15, 2, 'Apple', 5, 6);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;


-- Dumping structure for table mydb.routes
CREATE TABLE IF NOT EXISTS `routes` (
  `route_id` int(11) NOT NULL,
  `route_name` varchar(45) NOT NULL,
  PRIMARY KEY (`route_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mydb.routes: ~3 rows (approximately)
/*!40000 ALTER TABLE `routes` DISABLE KEYS */;
INSERT INTO `routes` (`route_id`, `route_name`) VALUES
	(1, 'HU1'),
	(2, 'HU2'),
	(3, 'HU3');
/*!40000 ALTER TABLE `routes` ENABLE KEYS */;


-- Dumping structure for table mydb.stock
CREATE TABLE IF NOT EXISTS `stock` (
  `product_product_id` int(11) NOT NULL,
  `product_supplier_supplier_id` int(11) NOT NULL,
  `stores_store_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`product_product_id`,`product_supplier_supplier_id`,`stores_store_id`),
  KEY `fk_product_has_stores_stores1_idx` (`stores_store_id`),
  KEY `fk_product_has_stores_product1_idx` (`product_product_id`,`product_supplier_supplier_id`),
  CONSTRAINT `fk_product_has_stores_product1` FOREIGN KEY (`product_product_id`, `product_supplier_supplier_id`) REFERENCES `product` (`product_id`, `supplier_supplier_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_stores_stores1` FOREIGN KEY (`stores_store_id`) REFERENCES `stores` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mydb.stock: ~3 rows (approximately)
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` (`product_product_id`, `product_supplier_supplier_id`, `stores_store_id`, `quantity`) VALUES
	(1, 2, 1, 20),
	(4, 3, 2, 40),
	(6, 2, 3, 1);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;


-- Dumping structure for table mydb.stores
CREATE TABLE IF NOT EXISTS `stores` (
  `store_id` int(11) NOT NULL,
  `store_name` varchar(50) DEFAULT NULL,
  `manager` varchar(50) NOT NULL,
  PRIMARY KEY (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mydb.stores: ~3 rows (approximately)
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
INSERT INTO `stores` (`store_id`, `store_name`, `manager`) VALUES
	(1, 'Main Depot', 'Ted'),
	(2, 'Express Depot', 'Will'),
	(3, 'Central Depot', 'Tracy');
/*!40000 ALTER TABLE `stores` ENABLE KEYS */;


-- Dumping structure for table mydb.supplier
CREATE TABLE IF NOT EXISTS `supplier` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(40) NOT NULL,
  `supplier_address` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mydb.supplier: ~5 rows (approximately)
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` (`supplier_id`, `supplier_name`, `supplier_address`) VALUES
	(1, 'Aldi', 'Hull'),
	(2, 'Coop', 'Goole'),
	(3, 'Sainsburys', 'Leeds'),
	(4, 'Tescos', 'Manchester'),
	(5, 'Waitrose', 'Goole');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;


-- Dumping structure for table mydb.vans
CREATE TABLE IF NOT EXISTS `vans` (
  `van_id` int(11) NOT NULL,
  `driver` varchar(45) NOT NULL,
  PRIMARY KEY (`van_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table mydb.vans: ~5 rows (approximately)
/*!40000 ALTER TABLE `vans` DISABLE KEYS */;
INSERT INTO `vans` (`van_id`, `driver`) VALUES
	(1, 'Bill'),
	(2, 'Ben'),
	(3, 'Dave\r\n'),
	(4, 'Adam'),
	(5, 'Sophie');
/*!40000 ALTER TABLE `vans` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
