-- 1ra solución
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
group by prod_codigo, prod_detalle;
		   
-- 2da solución
select 
	p.prod_codigo,
	p.prod_detalle,
	SUM(isnull(c.comp_cantidad, 0)) as ArticulosComponen
from Producto as p
left join Composicion as c on c.comp_producto = p.prod_codigo
right join (
	select 
		s.stoc_producto
	from STOCK as s
	group by s.stoc_producto
		having AVG(s.stoc_cantidad) > 100
) as stockProducto on stockProducto.stoc_producto = p.prod_codigo
group by p.prod_codigo, p.prod_detalle
order by ArticulosComponen desc;
