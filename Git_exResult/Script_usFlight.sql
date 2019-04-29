#Cantidad de registros de la tabla de vuelos:

SELECT count(*) from flights;

#Retraso promedio de salida y llegada según el aeropuerto origen

SELECT Origin, avg(ArrDelay), avg(DepDelay) 
FROM flights
GROUP BY Origin;


#Retraso promedio de llegada de los vuelos, por meses y según el aeropuerto origen.
#Además, quieren que los resultado se muestren de la siguiente forma (fíjate en el orden de las filas):

SELECT Origin, colYear, colMonth, avg(ArrDelay)
FROM flights
GROUP BY Origin, colYear, colMonth
ORDER By Origin, colYear DESC;


#Retraso promedio de llegada de los vuelos, por meses y según el aeropuerto origen 
#(misma consulta que antes y con el mismo orden). 
#Pero además, ahora quieren que en vez del código del aeropuerto se muestra 
#el nombre de la ciudad.


SELECT a.City, f.colYear, f.colMonth, avg(f.ArrDelay)
FROM usairports a 
INNER JOIN flights f ON (a.IATA=f.Origin)
GROUP BY a.City, f.colYear, f.colMonth
ORDER By a.City, f.colYear;

#Revisar resultado contra enunciado. El enunciado tiene un registro que no aparece en mis resultados.

#Las compañías con más vuelos cancelados, por meses y año. Además, 
#deben estar ordenadas de forma que las compañías con más cancelaciones aparezcan las primeras.

SELECT c.CarrierCode, f.colYear, f.colMonth, AVG(f.ArrDelay) as avg_delay, Sum(f.Cancelled) as total_cancelled
FROM carriers c 
INNER JOIN flights f ON (c.CarrierCode=f.UniqueCarrier)
WHERE f.Cancelled <> 0
Group by c.CarrierCode
Order by total_cancelled DESC;

#El identificador de los 10 aviones que más distancia han recorrido haciendo vuelos.

SELECT TailNum, SUM(Distance)
FROM flights
WHERE TailNum !=''
Group by 1
Order by 2 DESC
Limit 10;


#Compañías con su retraso promedio sólo de aquellas las que sus vuelos llegan a su destino 
#con un retraso promedio mayor de 10 minutos.

SELECT UniqueCarrier, avg(ArrDelay) as avg_delay
FROM flights
Where ArrDelay>10
group by UniqueCarrier
Order by avg_delay DESC;
