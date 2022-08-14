CREATE ROLE user1;

CREATE SCHEMA shop;

CREATE TABLE if not exists shop.producer (
    producer_id       SERIAL PRIMARY KEY,
    producer_name     VARCHAR(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS shop.product (
    product_id        SERIAL PRIMARY KEY,
    product_name      VARCHAR(64) NOT NULL,
    description       VARCHAR(64) NOT NULL,
    price             VARCHAR(32) NOT NULL, --check > 0  backend
    quantity          INTEGER NOT NULL,  --check > 0  backend
	producer_id integer,
    FOREIGN KEY (producer_id) REFERENCES shop.producer (producer_id)
);

CREATE TABLE IF NOT EXISTS shop.purchase (
    purchase_id       SERIAL PRIMARY KEY,
    sum               VARCHAR(32) NOT NULL,  --check > 0  backend
	delivery_id integer,
    FOREIGN KEY (delivery_id) REFERENCES delivery.delivery (delivery_id)
);
CREATE TABLE IF NOT EXISTS shop.category (
    category_id       SERIAL PRIMARY KEY,
    category_name     VARCHAR(32) NOT NULL
);
CREATE TABLE IF NOT EXISTS shop.product_to_category (
    product_id         INTEGER NOT NULL,
    category_id        INTEGER NOT NULL,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES shop.product (product_id),
    FOREIGN KEY (category_id) REFERENCES shop.category (category_id)
);

CREATE TABLE IF NOT EXISTS shop.product_to_purchase (
    product_id        INTEGER NOT NULL,
    purchase_id        INTEGER NOT NULL,
    quantity          INTEGER NOT NULL,
    PRIMARY KEY (product_id, purchase_id),
    FOREIGN KEY (product_id) REFERENCES shop.product (product_id),
    FOREIGN KEY (purchase_id) REFERENCES shop.purchase (purchase_id)
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_product_name  -- select all products with such a name. Useful when here're lots of product from different providers
    ON shop.product(product_name);

    CREATE UNIQUE INDEX IF NOT EXISTS idx_product_name_quantity -- select all products with such a name available for sale
    ON shop.product(product_name, quantity);