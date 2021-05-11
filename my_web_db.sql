
/**CREATING DATABASE: **/
CREATE DATABASE IF NOT EXISTS my_web_db;

drop table if exists downloads;
drop table if exists users;
drop table if exists products;

/**USERS TABLE: **/
CREATE TABLE IF NOT EXISTS users (
  user_id INT AUTO_INCREMENT,
  email_address VARCHAR(100),
  first_name VARCHAR(45),
  last_name VARCHAR(45),
  PRIMARY KEY(user_id)
) ENGINE = InnoDB;

/**PRODUCTS TABLE: **/
CREATE TABLE IF NOT EXISTS products (
  product_id INT,
  product_name VARCHAR(50),
  PRIMARY KEY(product_id)
) ENGINE = InnoDB;

/**DOWNLOADS TABLE: **/
CREATE TABLE IF NOT EXISTS downloads (
  download_id INT,
  user_id INT,
  download_date DATETIME,
  filename VARCHAR(50),
  product_id INT,
  PRIMARY KEY(download_id),
  CONSTRAINT fk_downloads_users
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  
  CONSTRAINT fk_downloads_products
  FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE = InnoDB;

/**Add two users into the users table: **/
INSERT INTO users VALUES (1,'saraa.riazi@gmail.com', 'Sara', 'Riazi');
INSERT INTO users VALUES (2,'johnsmith@gmail.com', 'John', 'Smith');
INSERT INTO users (email_address,first_name,last_name) 
VALUES ('janedoe@yahoo.com', 'Jane', 'Doe'); 

/**Insert forth row: **/
INSERT INTO users VALUES (4,'jackbrown@msn.com', 'jack', NULL);

/**Add two products into products table: **/
INSERT INTO products VALUES (1,'Local Music Vol. 1');
INSERT INTO products VALUES (2,'Local Music Vol. 2');

/**Now function: **/
INSERT INTO downloads VALUES (1, 1, NOW(), 'pedals_are_falling.mp3', 1),
 (2, 2, NOW(), 'turn_signal.mp3', 1),
 (3, 2, NOW(), 'one_horse_town.mp3', 2);

/**Update John's email address: **/
UPDATE users SET email_address = 'john.smith@yahoo.com'
WHERE user_id = 2;

/**Delete download: user_id (1) in database: **/
DELETE FROM downloads
WHERE user_id = 1;