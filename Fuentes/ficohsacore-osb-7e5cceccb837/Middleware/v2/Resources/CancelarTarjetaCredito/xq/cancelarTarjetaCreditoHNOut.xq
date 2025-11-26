(:: pragma bea:global-element-parameter parameter="$gestionesGenericasCRMResponse" element="ns0:gestionesGenericasCRMResponse" location="../../GestionesGenericasCRM/xsd/gestionesGenericasCRMTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cancelarTarjetaCreditoResponse" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesGenericasCRMTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarTarjetaCredito/xq/cancelarTarjetaCreditoHNOut/";

declare function xf:cancelarTarjetaCreditoHNOut($gestionesGenericasCRMResponse as element(ns0:gestionesGenericasCRMResponse))
    as element(ns1:cancelarTarjetaCreditoResponse) {
        <ns1:cancelarTarjetaCreditoResponse>
            <CASE_DETAILS>
                {
                    for $REFERENCE_ID in $gestionesGenericasCRMResponse/REFERENCE_ID
                    return
                        <REFERENCE>{ data($REFERENCE_ID) }</REFERENCE>
                }
            </CASE_DETAILS>
        </ns1:cancelarTarjetaCreditoResponse>
};

declare variable $gestionesGenericasCRMResponse as element(ns0:gestionesGenericasCRMResponse) external;

xf:cancelarTarjetaCreditoHNOut($gestionesGenericasCRMResponse)