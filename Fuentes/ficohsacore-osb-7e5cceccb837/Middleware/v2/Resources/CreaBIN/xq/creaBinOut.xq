(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DEBITCARD/configuraBin/xsd/configuraBin_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:creaBINResponse" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/configuraBin";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaBIN/xq/creaBinPAOut/";

declare function xf:creaBinPAOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:creaBINResponse) {
        <ns0:creaBINResponse>
            {
                for $PV_CREATION_DATE in $outputParameters/ns1:PV_CREATION_DATE
                return
                    <CREATION_DATE>{ data($PV_CREATION_DATE) }</CREATION_DATE>
            }
            {
                for $PV_RETURN_CODE in $outputParameters/ns1:PV_RETURN_CODE
                return
                    <STATUS>{ data($PV_RETURN_CODE) }</STATUS>
            }
        </ns0:creaBINResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:creaBinPAOut($outputParameters)