(:: pragma bea:global-element-parameter parameter="$pagoRemesasResponse1" element="ns0:pagoRemesasResponse" location="../xsd/pagoRemesaCB.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MDW/LimitesTransaccionalesTNG/limitesTransaccionalesActualizar/xsd/limitesTransaccionalesActualizar_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/limitesTransaccionalesActualizar";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesaCB/xq/limiteTransaccionalActOut/";

declare function xf:limiteTransaccionalActOut($pagoRemesasResponse1 as element(ns0:pagoRemesasResponse))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $ID in $pagoRemesasResponse1/BENEFICIARY_INFO/ID
                return
                    <ns1:PV_ID_CLIENTE>{ data($ID) }</ns1:PV_ID_CLIENTE>
            }
        </ns1:InputParameters>
};

declare variable $pagoRemesasResponse1 as element(ns0:pagoRemesasResponse) external;

xf:limiteTransaccionalActOut($pagoRemesasResponse1)
