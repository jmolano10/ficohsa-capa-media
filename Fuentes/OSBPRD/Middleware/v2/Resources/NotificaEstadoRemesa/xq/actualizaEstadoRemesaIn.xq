(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/Remesas/NotificaEstadoRemesa/xsd/notificaEstadoRemesa_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Remesas/NotificaEstadoRemesa/xsd/actualizaEstadoRemesa_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaEstadoRemesa";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/notificaEstadoRemesa";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEstadoRemesa/xq/actualizaEstadoRemesaIn/";

declare function xf:actualizaEstadoRemesaIn($outputParameters1 as element(ns1:OutputParameters),
    $numeroContrato as xs:string)
    as element(ns0:InputParameters) {
<ns0:InputParameters>
    <ns0:PV_NUMERO_CONTRATO>{ $numeroContrato }</ns0:PV_NUMERO_CONTRATO>
    <ns0:PV_CLAVES> { for $row in $outputParameters1/ns1:PC_REMESAS/ns1:Row let $folio :=
        $row/ns1:Column[@name = "FOLIO"] return <ns0:PV_CLAVES_ITEM>
            <ns0:CLAVE>{ data($folio)}</ns0:CLAVE>
        </ns0:PV_CLAVES_ITEM> } </ns0:PV_CLAVES>
</ns0:InputParameters>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $numeroContrato as xs:string external;

xf:actualizaEstadoRemesaIn($outputParameters1,
    $numeroContrato)