xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataHN/conDatoTarjetasActivasCliente_v2/xsd/conDatoTarjetasActivasCliente_V2_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTarjetasCreditoPorClienteResponse" location="../xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaTarjetasCreditoPorCliente/xq/consultaTarjetasCreditoPorClienteHN2Out/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetasActivasCliente_V2";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";

declare function convertirFecha($date as element(*)?) 
    as xs:string {
        if (fn-bea:trim(xs:string($date)) != '') then
            fn-bea:dateTime-to-string-with-format("yyyyMMdd", $date)  
        else ("")
};

declare function xf:consultaTarjetasCreditoPorClienteHN2Out($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaTarjetasCreditoPorClienteResponse) {
        
        <ns1:consultaTarjetasCreditoPorClienteResponse>
            <CREDIT_CARDS>
             {
               for $row in $outputParameters/ns0:RowSet/ns0:Row
               return
               <CREDIT_CARD_INFORMATION>
                  {
                        for $numeroTarjeta in $row/ns0:Column[@name = 'NumeroTarjeta']
                        return
                           <CREDIT_CARD_NUMBER>{ data($numeroTarjeta) }</CREDIT_CARD_NUMBER>
                  }
                  {
                        for $numeroCuenta in $row/ns0:Column[@name = 'NumeroCuenta']
                        return
                           <ACCOUNT_NUMBER>{ data($numeroCuenta) }</ACCOUNT_NUMBER>
                  }
                  {
                        for $nombreCompleto in $row/ns0:Column[@name = 'NombreCompleto']
                        return
                           <CARD_HOLDER_NAME>{ data($nombreCompleto) }</CARD_HOLDER_NAME>
                  }
                  {
                        for $categoriaTarjeta in $row/ns0:Column[@name = 'CategoriaTarjeta']
                        return
                           <CARD_TYPE>{ data($categoriaTarjeta) }</CARD_TYPE>
                  }
                  {
                        for $numeroTarjeta in $row/ns0:Column[@name = 'NumeroTarjeta']
                        return
                          	if (substring(data($numeroTarjeta), 1,1) = '4') then (
                                <CARD_BRAND>VISA</CARD_BRAND>
            				) else if (substring(data($numeroTarjeta), 1,1) = '5') then (
            					<CARD_BRAND>MASTER CARD</CARD_BRAND>
            				) else if (substring(data($numeroTarjeta), 1,1) = '3') then (
            					<CARD_BRAND>AMERICAN EXPRESS</CARD_BRAND>
                            ) else (
                                <CARD_BRAND>OTRA</CARD_BRAND>
                            )  
                  }
                  {
                        for $estadoTarjeta in $row/ns0:Column[@name = 'EstadoTarjeta']
                        return
                           <STATUS>{ data($estadoTarjeta) }</STATUS>
                  }
                  {
                        for $producto in $row/ns0:Column[@name = 'Producto']
                        return
                           <PRODUCT_TYPE>{ data($producto) }</PRODUCT_TYPE>
                  }
                  {
                        for $grupoAfinidad in $row/ns0:Column[@name = 'GrupoAfinidad']
                        return
                           <AFINITY_GROUP>{ data($grupoAfinidad) }</AFINITY_GROUP>
                  }
                  {
                        for $fecApertura in $row/ns0:Column[@name = 'fecapertura']
                        return
                           <CARD_EFFECTIVE_DATE>{ convertirFecha($fecApertura) }</CARD_EFFECTIVE_DATE>
                  }
               </CREDIT_CARD_INFORMATION>
             }
            </CREDIT_CARDS>
        </ns1:consultaTarjetasCreditoPorClienteResponse>
        
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaTarjetasCreditoPorClienteHN2Out($outputParameters)