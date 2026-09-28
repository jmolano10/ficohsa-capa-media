(:: pragma bea:global-element-parameter parameter="$eliminarDeudores1" element="ns0:eliminarDeudores" location="../../DepositosReferenciados/xsd/depositosReferenciadosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/eliminarDeudoresDepRef/xsd/eliminarDeudoresDepRef_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositosReferenciadosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eliminarDeudoresDepRef";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/eliminarDeudoresDepRef/xq/eliminarDeudoresDepRefIn/";

declare function xf:eliminarDeudoresDepRefIn($eliminarDeudores1 as element(ns0:eliminarDeudores))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGOCLIENTE>{ data($eliminarDeudores1/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
            <ns1:PV_NUMEROCUENTA>{ data($eliminarDeudores1/ACCOUNT_NUMBER) }</ns1:PV_NUMEROCUENTA>
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

xf:eliminarDeudoresDepRefIn($eliminarDeudores1)