(:: pragma bea:global-element-parameter parameter="$eliminarDeudores1" element="ns0:eliminarDeudores" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/eliminarDeudores/xsd/eliminarDeudores_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eliminarDeudores";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EliminarDeudores/xq/eliminarDeudoresHNIn/";

declare function xf:eliminarDeudoresHNIn($eliminarDeudores1 as element(ns0:eliminarDeudores))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGOCLIENTE>{ data($eliminarDeudores1/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
            <ns1:PV_NUMEROCONTRATO>{ data($eliminarDeudores1/CONTRACT_ID) }</ns1:PV_NUMEROCONTRATO>
            <ns1:PT_CODIGODEUDORES>
                {
                    for $DEBTOR in $eliminarDeudores1/DEBTORS/DEBTOR
                    return
                        <ns1:ITEM>{ data($DEBTOR/DEBTOR_CODE) }</ns1:ITEM>
                }
            </ns1:PT_CODIGODEUDORES>
        </ns1:InputParameters>
};

declare variable $eliminarDeudores1 as element(ns0:eliminarDeudores) external;

xf:eliminarDeudoresHNIn($eliminarDeudores1)