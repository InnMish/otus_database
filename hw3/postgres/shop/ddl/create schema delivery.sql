CREATE SCHEMA delivery;

CREATE TABLE IF NOT EXISTS delivery.customer (
    customer_id       SERIAL PRIMARY KEY,
    first_name        VARCHAR(32) NOT NULL,
    last_name         VARCHAR(32),
    address           VARCHAR(64) NOT NULL,
    phone             VARCHAR(16) NOT NULL
);

CREATE TABLE IF NOT EXISTS delivery.provider (
    provider_id       SERIAL PRIMARY KEY,
    provider_name     VARCHAR(32) NOT NULL,
    address           VARCHAR(64)
);

CREATE TABLE IF NOT EXISTS delivery.delivery (
    delivery_id       SERIAL PRIMARY KEY,
    delivery_date     TIMESTAMP NOT NULL, --check date is valid  backend
	customer_id integer,
	provider_id integer,
    FOREIGN KEY (customer_id) REFERENCES delivery.customer (customer_id),
    FOREIGN KEY (provider_id) REFERENCES delivery.provider (provider_id)
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_delivery_date -- select all deliveries on the exact date. Useful when here're many deliveries a day
    ON delivery.delivery(delivery_date);