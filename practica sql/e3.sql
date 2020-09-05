select 
	producto.prod_codigo, 
	producto.prod_detalle,
	SUM(isnull(stock.stoc_cantidad,0)) as cantidad
from Producto as producto
left join STOCK as stock on producto.prod_codigo = stock.stoc_producto
left join DEPOSITO as deposito on stock.stoc_deposito = deposito.depo_codigo
group by producto.prod_codigo, producto.prod_detalle
order by producto.prod_detalle

