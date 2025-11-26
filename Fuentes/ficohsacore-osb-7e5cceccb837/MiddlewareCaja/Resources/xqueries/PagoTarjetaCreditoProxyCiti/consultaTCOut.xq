(:: pragma bea:global-element-parameter parameter="$consultarSaldosResponse1" element="ns0:consultarSaldosResponse" location="../../wsdls/Alcance.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consulta_cuenta_ECSResponse" location="../../wsdls/PagoTarjetaCreditoProxyCiti.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCreditoFicohsa/consultaTCOut/";

declare function xf:consultaTCOut($consultarSaldosResponse1 as element(ns0:consultarSaldosResponse))
    as element(ns0:consulta_cuenta_ECSResponse) {
        <ns0:consulta_cuenta_ECSResponse>
            {
                for $nombreTitular in $consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:nombreTitular
                return
                    <ns0:nombre>{ data($nombreTitular) }</ns0:nombre>
            }
            {
                let $estatusConfirmacion := fn:string($consultarSaldosResponse1/ns0:consultarSaldosResult/ns0:estatusConfirmacion/text())
                return
                    if ($estatusConfirmacion = "97") then (
                    	<ns0:sError>00</ns0:sError>
                    ) else if ($estatusConfirmacion = "98") then (
                    	<ns0:sError>99</ns0:sError>
                    ) else (
                    	<ns0:sError>{ $estatusConfirmacion }</ns0:sError>
                    )
            }
        </ns0:consulta_cuenta_ECSResponse>
};

declare variable $consultarSaldosResponse1 as element(ns0:consultarSaldosResponse) external;

xf:consultaTCOut($consultarSaldosResponse1)