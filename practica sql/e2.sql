select 
	producto.prod_codigo,
	producto.prod_detalle
from Factura as factura
inner join Item_Factura as item on factura.fact_numero = item.item_numero and factura.fact_tipo = item.item_tipo and factura.fact_sucursal = item.item_sucursal
inner join Producto as producto on producto.prod_codigo = item.item_producto
where factura.fact_fecha between '01-01-2012' and '12-31-2012'
group by 
	producto.prod_detalle,
	producto.prod_codigo
order by SUM(item.item_cantidad) desc
