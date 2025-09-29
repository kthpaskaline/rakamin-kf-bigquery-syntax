//BIGSYNTAX TABEL ANALISIS KINERJA KIMIA FARMA TAHUN 2020-2023

CREATE TABLE `kimia_farma.analysis_table` AS
SELECT
  t.transaction_id,
  t.date,
  t.branch_id,
  kc.branch_name,
  kc.kota,
  kc.provinsi,
  kc.rating AS rating_cabang,
  t.customer_name,
  t.product_id,
  p.product_name,
  t.price AS actual_price,
  t.discount_percentage,
  CASE
    WHEN t.price <= 50000 THEN 0.10
    WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
    WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
    WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
    WHEN t.price > 500000 THEN 0.30
  END AS persentase_gross_laba,
  ROUND(t.price * (1 - t.discount_percentage/100), 2) AS nett_sales,
  ROUND(t.price * (1 - t.discount_percentage/100) *
        CASE
          WHEN t.price <= 50000 THEN 0.10
          WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
          WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
          WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
          WHEN t.price > 500000 THEN 0.30
        END, 2) AS nett_profit,
  t.rating AS rating_transaksi
FROM `kimia_farma.kf_final_transaction` t
LEFT JOIN `kimia_farma.kf_product` p
  ON t.product_id = p.product_id
LEFT JOIN `kimia_farma.kf_kantor_cabang` kc
  ON t.branch_id = kc.branch_id;
