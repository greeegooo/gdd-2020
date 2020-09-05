select 
	cli.clie_codigo,
	cli.clie_razon_social
from dbo.cliente as cli
where clie_limite_credito >= 1000
order by clie_codigo;