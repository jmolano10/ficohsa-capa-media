xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABK/eliminarDeudores/xsd/eliminarDeudores_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$eliminarDeudores1" element="ns0:eliminarDeudores" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:eliminarDeudoresResponse" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eliminarDeudores";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AfiliacionDeudores/xq/eliminarDeudoresHNOut/";

declare function xf:eliminarDeudoresHNOut($outputParameters1 as element(ns1:OutputParameters),
    $eliminarDeudores1 as element(ns0:eliminarDeudores))
    as element(ns0:eliminarDeudoresResponse) {
        <ns0:eliminarDeudoresResponse>
            <CUSTOMER_ID>{ data($eliminarDeudores1/CUSTOMER_ID) }</CUSTOMER_ID>
            {
                for $PV_NUMEROCONTRATO in $outputParameters1/ns1:PV_NUMEROCONTRATO
                return
                    <CONTRACT_ID>{ data($PV_NUMEROCONTRATO) }</CONTRACT_ID>
            }
            <DEBTORS>                
            {                	
                let $deudor := $outputParameters1/ns1:PT_CODIGODEUDORES/ns1:ITEM 
                let $estado := $outputParameters1/ns1:PT_ESTADODEUDORES/ns1:ITEM
                let $mensaje := $outputParameters1/ns1:PT_MENSAJEDEUDORES/ns1:ITEM                	
                for $i in 1 to count($estado)
                return
                <DEBTOR>
                	<DEBTOR_CODE>{data($deudor[$i])}</DEBTOR_CODE>
                	<STATUS>{data($estado[$i])}</STATUS>
                	<MESSAGES>{data($mensaje[$i])}</MESSAGES>
                </DEBTOR>
            }
            </DEBTORS>
        </ns0:eliminarDeudoresResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $eliminarDeudores1 as element(ns0:eliminarDeudores) external;

xf:eliminarDeudoresHNOut($outputParameters1,
    $eliminarDeudores1)