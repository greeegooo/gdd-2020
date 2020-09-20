WITH items_vendidos AS (
    select
		YEAR(f.fact_fecha) as [Fecha Factura],
		SUM(ifa.item_cantidad) as [Cantidad Item],
		ifa.item_producto as [Numero Producto]
	from Factura as f
		left join Item_Factura as ifa on f.fact_numero = ifa.item_numero
	group by ifa.item_producto, YEAR(f.fact_fecha)
) 
SELECT 
	iv1.[Numero Producto],
	iv1.[Cantidad Item],
	p.prod_detalle
FROM items_vendidos as iv1
	JOIN items_vendidos as iv2 on iv1.[Numero Producto] = iv2.[Numero Producto]
	JOIN Producto as p on p.prod_codigo = iv1.[Numero Producto]
where iv1.[Fecha Factura] = 2012 and iv2.[Fecha Factura] = 2011 and iv1.[Cantidad Item] > iv2.[Cantidad Item];
