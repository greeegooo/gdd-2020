select 
	prod_codigo as Codigo,
	prod_detalle as Detalle,
	comp_cantidad as Cantidad
from Producto as producto
left join Composicion on prod_codigo = comp_producto
where (
	select 
		AVG(stoc_cantidad) 
		from STOCK 
		where stoc_producto = comp_componente
		group by stoc_producto) > 100