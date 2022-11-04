CREATE TABLE if not exists producer (
    producer_id       integer autoincrement PRIMARY KEY,
    producer_name     VARCHAR(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS product (
    product_id        serial PRIMARY KEY,
    product_name      VARCHAR(64) NOT NULL,
    description       JSON NOT NULL,
    price             DECIMAL NOT NULL,
    quantity          INTEGER NOT NULL,
    producer_id BIGINT UNSIGNED,
    FOREIGN KEY (producer_id) REFERENCES producer (producer_id)
);

CREATE TABLE IF NOT EXISTS category (
    category_id       serial PRIMARY KEY,
    category_name     VARCHAR(32) NOT NULL
);

CREATE TABLE IF NOT EXISTS purchase (
    purchase_id       serial PRIMARY KEY,
    sum               VARCHAR(32) NOT NULL,
	delivery_id BIGINT UNSIGNED,
    FOREIGN KEY (delivery_id) REFERENCES delivery (delivery_id)
);


CREATE TABLE IF NOT EXISTS product_to_category (
    product_id         BIGINT UNSIGNED NOT NULL,
    category_id        BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id),
    FOREIGN KEY (category_id) REFERENCES category (category_id)
);

CREATE TABLE IF NOT EXISTS product_to_purchase (
    product_id        BIGINT UNSIGNED NOT NULL,
    purchase_id        BIGINT UNSIGNED NOT NULL,
    quantity          INTEGER NOT NULL,
    PRIMARY KEY (product_id, purchase_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id),
    FOREIGN KEY (purchase_id) REFERENCES purchase (purchase_id)
);
