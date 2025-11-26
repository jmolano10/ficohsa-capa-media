(:: pragma bea:global-element-parameter parameter="$actualizaDatosClienteIN" element="ns0:actualizaDatosCliente" location="../xsd/actualizacionDatosCliente.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeaderIN" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/Cobis/ActualizacionDatosCliente/xsd/ActualizacionDatosCliente_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ActualizacionDatosCliente";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaDatosClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizacionDatosCliente/xq/actualizaDatosClienteNIIN/";

(: Retorna el codigo de direccion :)
declare function type-of-address 
  ( $sector as xs:string )  as xs:string {
  if (fn:string($sector) = "DO") then (
  	"1")
  	elseif (fn:string($sector) = "OF") then (
  	"2")
  else (
  	"3"
  )
};

declare function xf:actualizaDatosClienteNIIN($actualizaDatosClienteIN as element(ns0:actualizaDatosCliente),
    $requestHeaderIN as element(ns2:RequestHeader),
    $TrxCode as xs:string,
    $Channel as xs:string,
    $Date as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:i_pais>{ data($requestHeaderIN/Region/SourceBank) }</ns1:i_pais>
            <ns1:i_user>{ data($requestHeaderIN/Authentication/UserName) }</ns1:i_user>
            <ns1:i_canal>{ $Channel }</ns1:i_canal>
            <ns1:i_fecha>{data($Date) }</ns1:i_fecha>
            <ns1:t_trn>{ data($TrxCode) }</ns1:t_trn>
            <ns1:i_oficina></ns1:i_oficina>
            <ns1:i_di_ente>{data($actualizaDatosClienteIN/CUSTOMER_ID) }</ns1:i_di_ente> 
            {
             for $BLOCK at $i in $actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK
             
           return
           if (count(data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[TYPE='ADDRESS']/TYPE/text()))>0) then(  
          
            for $BLOCK at $i in $actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK
            let $contador:=count($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM) 
            for $f in (1 to $contador )  
            let $contadorIndice:=count($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD)
            let $DireccionCompleta:=''
            return
            if ($BLOCK/TYPE='ADDRESS' and $actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/ID='ADDRESS_TYPE') then (
             <ns1:i_pais_dir>
             {
             
             for $g in (1 to $contadorIndice )  
                return
                       
                       if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='COUNTRY_CODE') then
                           data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) 
                         else()       
                 }
                 </ns1:i_pais_dir>,
                 <ns1:i_departamento_dir>
                 {
                  for $g in (1 to $contadorIndice )
                return
                      if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='STATE_CODE') then
                        data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) 
                          else()       
                 }
                </ns1:i_departamento_dir>,
                 <ns1:i_municipio_dir>
                 {
                  for $g in (1 to $contadorIndice )
                return
                      if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='MUNICIPALITY_CODE') then
                        data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) 
                          else()       
                 }
                </ns1:i_municipio_dir>,
                
                  <ns1:i_codigo_dir>
                 {
                  type-of-address(data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/INDEX_ID))             
                 }
                </ns1:i_codigo_dir>,
                 <ns1:i_descripcion_dir>
                 {
                  for $g in (1 to $contadorIndice )
                return
                      if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='REFERENCES') then
                        data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE) 
                          else()       
                 }
                </ns1:i_descripcion_dir>          
             )
             else()
             )
             else(
              <ns1:i_pais_dir> </ns1:i_pais_dir>,
               <ns1:i_departamento_dir></ns1:i_departamento_dir>,
               <ns1:i_municipio_dir></ns1:i_municipio_dir>,
               <ns1:i_codigo_dir></ns1:i_codigo_dir>,
               <ns1:i_descripcion_dir></ns1:i_descripcion_dir>
             )           
            }  
            {       
           for $BLOCK at $i in $actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK
         
           return  
           if (count(data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[TYPE='PHONES']/TYPE/text()))>0) then(   
             let $contador:=count($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM)   
             for $f in (1 to $contador )
             let $contadorIndice:=count($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD)
                let $zipcode:=$actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[ID='ZIP_CODE']/VALUE
             for $g in (1 to $contadorIndice )
                return
                    if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/ID='PHONE_NUMBER' 
                         and $BLOCK/TYPE='PHONES' and $actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/ID='SMS') then(
                                   if ($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE!='') then (
                                  <ns1:i_codigo_tel>{data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/INDEX_ID)}</ns1:i_codigo_tel>,
                                  <ns1:i_descripcion_tel>{concat($zipcode, data($actualizaDatosClienteIN/CUSTOMER_BLOCKS/BLOCK[$i]/ITEMS/ITEM[$f]/FIELDS/FIELD[$g]/VALUE)) }</ns1:i_descripcion_tel>
                                   ) 
                                  else(
                                   <ns1:i_codigo_tel></ns1:i_codigo_tel>,
                                   <ns1:i_descripcion_tel></ns1:i_descripcion_tel>)
                               )
                       
                       else()
           
           
            )
            else(
            <ns1:i_codigo_tel></ns1:i_codigo_tel>,
            <ns1:i_descripcion_tel></ns1:i_descripcion_tel>
            )
           }
        </ns1:InputParameters>
};

declare variable $actualizaDatosClienteIN as element(ns0:actualizaDatosCliente) external;
declare variable $requestHeaderIN as element(ns2:RequestHeader) external;
declare variable $TrxCode as xs:string external;
declare variable $Channel as xs:string external;
declare variable $Date as xs:string external;

xf:actualizaDatosClienteNIIN($actualizaDatosClienteIN,
    $requestHeaderIN,
    $TrxCode,
    $Channel,
    $Date)
