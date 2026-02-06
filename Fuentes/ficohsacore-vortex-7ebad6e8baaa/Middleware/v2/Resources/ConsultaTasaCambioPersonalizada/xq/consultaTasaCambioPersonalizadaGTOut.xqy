xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaTasaCambioPersonalizada/xsd/consultaTasaCambioPersonalizada_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTasaCambioPersonalizadaResponse" location="../xsd/consultaTasaCambioPersonalizadaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioPersonalizadaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTasaCambioPersonalizada";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTasaCambioPersonalizada/xq/consultaTasaCambioPersonalizadaGTOut/";

declare function xf:consultaTasaCambioPersonalizadaGTOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaTasaCambioPersonalizadaResponse) {
        <ns0:consultaTasaCambioPersonalizadaResponse>
            {
                for $PV_TASADECOMPRA in $outputParameters/ns1:PN_TASADECOMPRA
                return
                	if(data($PV_TASADECOMPRA) != '')then(
                    	<ns0:BUY_RATE>{ round-half-to-even(number(data($PV_TASADECOMPRA)), 4) }</ns0:BUY_RATE>
                    )else()
            }
            {
                for $PV_TASADEVENTA in $outputParameters/ns1:PN_TASADEVENTA
                return
                	if(data($PV_TASADEVENTA) != '')then(
                    	<ns0:SELL_RATE>{ round-half-to-even(number(data($PV_TASADEVENTA)), 4) }</ns0:SELL_RATE>
                    )else()
            }
        </ns0:consultaTasaCambioPersonalizadaResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaTasaCambioPersonalizadaGTOut($outputParameters)