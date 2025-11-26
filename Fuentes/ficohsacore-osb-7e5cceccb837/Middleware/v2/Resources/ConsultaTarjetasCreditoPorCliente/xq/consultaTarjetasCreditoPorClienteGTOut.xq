<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataGT/conDatoTarjetasActivasCliente/xsd/conDatoTarjetasActivasCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTarjetasCreditoPorClienteResponse" location="../xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEnvioEstadoCuenta/xq/consultaTarjetasCreditoPorClienteGTOut/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetasActivasCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";

declare function xf:consultaTarjetasCreditoPorClienteGTOut($outputParameters as element(ns0:OutputParameters))
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
               </CREDIT_CARD_INFORMATION>
             }
            </CREDIT_CARDS>
        </ns1:consultaTarjetasCreditoPorClienteResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaTarjetasCreditoPorClienteGTOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MasterDataGT/conDatoTarjetasActivasCliente/xsd/conDatoTarjetasActivasCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterDataGT/conDatoTarjetasActivasCliente/xsd/conDatoTarjetasActivasCliente_sp"/>
    </con:dependency>
    <con:dependency location="../xsd/consultaTarjetasCreditoPorClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaTarjetasCreditoPorCliente/xsd/consultaTarjetasCreditoPorClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>