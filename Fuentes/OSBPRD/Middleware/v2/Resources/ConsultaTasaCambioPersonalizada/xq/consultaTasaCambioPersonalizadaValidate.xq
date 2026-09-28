(:: pragma bea:global-element-parameter parameter="$consultaTasaCambioPersonalizada" element="ns0:consultaTasaCambioPersonalizada" location="../xsd/consultaTasaCambioPersonalizadaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioPersonalizadaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTasaCambioPersonalizada/xq/consultaTasaCambioPersonalizadaValidate/";

declare function xf:consultaTasaCambioPersonalizadaValidate($consultaTasaCambioPersonalizada as element(ns0:consultaTasaCambioPersonalizada))
    as xs:string {
        let $ticket   := string($consultaTasaCambioPersonalizada/ns0:RATE_INFORMATION/ns0:AUTHORIZATION_TICKET/text()) 
        let $rateType := string($consultaTasaCambioPersonalizada/ns0:RATE_INFORMATION/ns0:RATE_TYPE/text())
        return
        	if( $rateType = 'NEGOTIATED' )then(
        		if( $ticket != '')then(
        			''
        		)else(
        			'El campo AUTHORIZATION_TICKET es requerido.'
        		)
        	)else(
        		'Tipo de tasa de cambio no implementado.'
        	)
};

declare variable $consultaTasaCambioPersonalizada as element(ns0:consultaTasaCambioPersonalizada) external;

xf:consultaTasaCambioPersonalizadaValidate($consultaTasaCambioPersonalizada)