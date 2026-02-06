xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABK/eliminarDeudoresDepRef/xsd/eliminarDeudoresDepRef_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:eliminarDeudoresResponse" location="../../DepositosReferenciados/xsd/depositosReferenciadosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositosReferenciadosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eliminarDeudoresDepRef";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/eliminarDeudoresDepRef/xq/eliminarDeudoresDepRefOut/";

declare function xf:eliminarDeudoresDepRefOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:eliminarDeudoresResponse) {
        <ns0:eliminarDeudoresResponse>
            <CUSTOMER_ID>{ data($outputParameters1/ns1:PV_CODIGOCLIENTE) }</CUSTOMER_ID>
            <ACCOUNT_NUMBER>{ data($outputParameters1/ns1:PV_NUMEROCUENTA) }</ACCOUNT_NUMBER>
            <DEBTORS>
                {
                    let $deudores := $outputParameters1/ns1:PT_CODIGODEUDORES/ns1:ITEM
                    let $estados := $outputParameters1/ns1:PT_ESTADODEUDORES/ns1:ITEM
                    let $mensajes := $outputParameters1/ns1:PT_MENSAJEDEUDORES/ns1:ITEM                   
                    for $i in 1 to count($deudores)
                    return
                        <DEBTOR>
                            <DEBTOR_CODE>{ data($deudores[$i]) }</DEBTOR_CODE>
                            <STATUS>{ data($estados[$i]) }</STATUS>
                            <MESSAGES>{ data($mensajes[$i]) }</MESSAGES>
                        </DEBTOR>
                }
            </DEBTORS>
        </ns0:eliminarDeudoresResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:eliminarDeudoresDepRefOut($outputParameters1)