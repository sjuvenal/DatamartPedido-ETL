delete from HechoPedido
delete from DimensionCliente
delete from DimensionEmpleado
delete from DimensionProducto
delete from DimensionTiempo
delete from DimensionTransporte



--CLIENTE
select idCliente,NombreCompañia,Pais,Ciudad
from neptuno..clientes

select * from DataMartNeptuno..DimensionCliente

--EMPLEADO
select IdEmpleado,Apellidos+', '+Nombre as NombreEmpleado
from neptuno..Empleados

select * from DataMartNeptuno..DimensionEmpleado
--TRANSPORTE
select idCompañiaEnvios,nombreCompañia
from neptuno..[compañiasdeenvios]

select * from DataMartNeptuno..DimensionTransporte

--PRODUCTO
select p.idproducto,p.nombreProducto,c.nombrecategoria,
p.precioUnidad
from neptuno..productos p inner join neptuno..categorias c on
p.idCategoria=c.idcategoria

select * from DataMartNeptuno..DimensionProducto

--TIEMPO
select distinct FechaPedido,MONTH(FechaPedido) as Mes,
YEAR(FechaPedido) as Año,
DATEPART(QQ,FechaPedido) as Trimestre
from neptuno..Pedidos

select * from DataMartNeptuno..DimensionTiempo

--PEDIDOS
select IdCliente,IdEmpleado,cast(FechaPedido as datetime) FechaPedido ,idproducto,
FormaEnvio,p.IdPedido,DP.cantidad*DP.preciounidad AS MontoVneta,
dp.cantidad,
Cargo*cantidad/
	(
	select SUM(d1.cantidad) from neptuno..detallesdepedidos d1
	where d1.idpedido=dp.idpedido
	) as MontoFlete
from Pedidos p inner join 
detallesdepedidos DP
on p.IdPedido=dp.idpedido
