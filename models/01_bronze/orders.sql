MODEL (
  name bronze.orders,
  kind SEED (
    path '../../seeds/seed_data.csv'
  ),
  columns (
    id INTEGER,
    item_id INTEGER,
    event_date DATE
  ),
  grain (id, event_date)
);
  