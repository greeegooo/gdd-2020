select
	prod_codigo as Codigo,
	prod_detalle as Detalle,
	SUM(ISNULL(comp_cantidad, 0)) as Cantidad
from Producto
left join Composicion on prod_codigo = comp_producto
where (
	select
	AVG(stoc_cantidad)
	from STOCK
	where stoc_producto = prod_codigo
	group by stoc_producto) > 100
group by prod_codigo, prod_detalle