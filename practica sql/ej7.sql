select 
	p.prod_codigo as [Código de Artículo],
	p.prod_detalle as [Detalle de Artículo],
	ifa.[Mayor Precio] as [Mayor Precio],
	ifa.[Menor Precio] as [Menor Precio],
	CONCAT(cast(100 - (ifa.[Menor Precio] * 100 / ifa.[Mayor Precio]) as int), '%') as [de Diferencia]
from Producto as p
left join (
	select 
		ifa.item_producto as [Código de Artículo],
		MAX(ifa.item_precio) as [Mayor Precio],
		MIN(ifa.item_precio) as [Menor Precio]
	from Item_Factura as ifa
	group by ifa.item_producto
) as ifa on ifa.[Código de Artículo] = p.prod_codigo
where exists (
	select * from STOCK as st where st.stoc_producto = p.prod_codigo and st.stoc_cantidad > 0
);
