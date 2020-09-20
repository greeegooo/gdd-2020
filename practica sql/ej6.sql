select 
	p.prod_rubro as [Codigo Rubro],
	r.rubr_detalle as [Detalle Rubro],
	COUNT(1) AS [Cantidad Articulos],
	MAX(suma_stock.[Stock Cantidad]) as [Stock Total] -- Siempre viene 1 valor, pero no podia hacerlo de otra forma porque el group causa que el count devuelva 1
from Producto as p
	join Rubro as r on r.rubr_id = p.prod_rubro
	join (
		select 
			SUM(s.stoc_cantidad) as [Stock Cantidad],
			s.stoc_producto as [Codigo Producto]
		from STOCK as s
		group by s.stoc_producto
		having SUM(s.stoc_cantidad) > (select s2.stoc_cantidad from STOCK as s2 where s2.stoc_producto = '00000000' and s2.stoc_deposito = '00')
	) as suma_stock on suma_stock.[Codigo Producto] = p.prod_codigo 
group by p.prod_rubro, r.rubr_detalle;
