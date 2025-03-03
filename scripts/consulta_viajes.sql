SELECT 
    v.id_viaje, 
    v.id_tarjeta, 
    (v.etapas_subte + v.etapas_tren + v.etapas_colectivo) AS etapas_totales,
    d_o.departamento AS nombre_departamento_origen, 
    d_d.departamento AS nombre_departamento_destino,
    v.lon_o, v.lon_d, v.lat_o, v.lat_d,
    COUNT(v.id_viaje) OVER (PARTITION BY v.id_tarjeta) AS cantidad_viajes_por_tarjeta
FROM viajes v
LEFT JOIN departamentos d_o ON CAST(v.departamento_o AS INTEGER) = d_o.link_departamento
LEFT JOIN departamentos d_d ON CAST(v.departamento_d AS INTEGER) = d_d.link_departamento
WHERE (v.etapas_subte + v.etapas_tren + v.etapas_colectivo) <= 5
