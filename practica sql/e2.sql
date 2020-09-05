select 
	item.item_producto,
	producto.prod_detalle,
	SUM(item.item_cantidad) as cantidad
	--factura.fact_fecha
from Factura as factura
inner join Item_Factura as item on factura.fact_numero = item.item_numero
inner join Producto as producto on producto.prod_codigo = item.item_producto
where factura.fact_fecha between '01-01-2012' and '12-31-2012'
group by 
	producto.prod_detalle,
	item.item_producto
order by cantidad desc
