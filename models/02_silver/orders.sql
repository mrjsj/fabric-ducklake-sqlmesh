MODEL (
  name silver.orders,
  kind INCREMENTAL_BY_TIME_RANGE (
    time_column event_date
  ),
  start '2020-01-01',
  cron '@daily',
  grain (id, event_date)
);

SELECT
  id,
  item_id,
  event_date::TIMESTAMP,
FROM
  bronze.orders
WHERE
  event_date BETWEEN @start_date AND @end_date
  