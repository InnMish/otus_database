CREATE TABLE IF NOT EXISTS customer (
    customer_id       serial PRIMARY KEY,
    first_name        VARCHAR(32) NOT NULL,
    last_name         VARCHAR(32),
    address           VARCHAR(64) NOT NULL,
    phone             VARCHAR(16) NOT NULL
);

CREATE TABLE IF NOT EXISTS provider (
    provider_id       serial PRIMARY KEY,
    provider_name     VARCHAR(32) NOT NULL,
    details           JSON,
    address           VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS delivery (
    delivery_id       serial PRIMARY KEY,
    delivery_date     DATETIME NOT NULL,
    customer_id BIGINT UNSIGNED,
    provider_id BIGINT UNSIGNED,
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    FOREIGN KEY (provider_id) REFERENCES provider (provider_id)
);