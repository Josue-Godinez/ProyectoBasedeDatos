create or replace procedure prc_productosporvencer(idnegocio in negocios.id_negocio%type, listaXsemana out varchar2, listaXbodega out varchar2) is
 
 CURSOR productosMeses is
        select p.* from lotes p join bodegas b on b.id_bodega = p.id_bodega where p.fecha_registro < ADD_MONTHS(sysdate,  -6) and p.estado_ubicacion like 'B' and b.id_negocio = idnegocio; 
 CURSOR productosSemana is                                     
        select p.* from lotes p join bodegas b on b.id_bodega = p.id_bodega where p.fecha_caduca < sysdate + 8 and p.fecha_caduca > sysdate and b.id_negocio = idnegocio ;  
begin
  listaXsemana := 'Productos proximo a vencer -> ';
  listaXbodega := 'Productos con mas de 6 meses en bodega -> ';
  FOR n IN productosMeses LOOP
      listaXbodega := concat(listaXbodega, n.id_lote); 
  end loop;
  
  FOR n IN productosSemana LOOP
      listaXsemana := concat(listaXsemana, n.id_lote);
  end loop;  
end prc_productosporvencer;
/
