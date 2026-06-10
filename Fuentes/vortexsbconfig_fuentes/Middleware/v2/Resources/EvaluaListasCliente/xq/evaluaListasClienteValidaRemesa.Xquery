<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$evaluaListasClienteRequest" element="ns0:evaluaListasClienteRequest" location="../xsd/evaluaListasClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/SecValidaRemesaenListas/xsd/validaRemesasenListas_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/evaluaListasClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaRemesasenListas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaListasCliente/xq/evaluaListasClienteValidaRemesa/";

declare function xf:evaluaListasClienteValidaRemesa($evaluaListasClienteRequest as element(ns0:evaluaListasClienteRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $TRANSACTION_ID in $evaluaListasClienteRequest/TRANSACTION_ID
                return
                    <ns1:PV_CLAVE>{ data($TRANSACTION_ID) }</ns1:PV_CLAVE>
            }
            {
                for $TYPE_OF_TRANSACTION in $evaluaListasClienteRequest/TYPE_OF_TRANSACTION
                return
                    <ns1:PV_TIPO_TRANSACCION>{ data($TYPE_OF_TRANSACTION) }</ns1:PV_TIPO_TRANSACCION>
            }
            {
                for $NAME_TO_EVALUATE in $evaluaListasClienteRequest/NAME_TO_EVALUATE
                return
                    <ns1:PV_NOMBRE_ORDENANTE>{ data($NAME_TO_EVALUATE) }</ns1:PV_NOMBRE_ORDENANTE>
            }
           	<ns1:PD_FECHA_PAGO>{ fn:current-dateTime() }</ns1:PD_FECHA_PAGO>
            <ns1:PD_MONTO>{xs:decimal(fn:string($evaluaListasClienteRequest/AMOUNT/text()))}</ns1:PD_MONTO>
        </ns1:InputParameters>
};

declare variable $evaluaListasClienteRequest as element(ns0:evaluaListasClienteRequest) external;

xf:evaluaListasClienteValidaRemesa($evaluaListasClienteRequest)]]></con:xquery>
    <con:dependency location="../xsd/evaluaListasClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/EvaluaListasCliente/xsd/evaluaListasClienteTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/SecValidaRemesaenListas/xsd/validaRemesasenListas_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SecValidaRemesaenListas/xsd/validaRemesasenListas_sp"/>
    </con:dependency>
</con:xqueryEntry>