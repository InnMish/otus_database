CREATE TABLE if not exists producer (
    producer_id       BINARY(16) PRIMARY KEY,
    producer_name     VARCHAR(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS product (
    product_id        BINARY(16) PRIMARY KEY,
    product_name      VARCHAR(64) NOT NULL,
    description       JSON NOT NULL,
    price             DECIMAL NOT NULL,
    quantity          INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS category (
    category_id       BINARY(16) PRIMARY KEY,
    category_name     VARCHAR(32) NOT NULL
);
