(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../xsds/ConsultarTipoReversion/consultarTipoReversionT24/MIDDLEWARE_OSB_CONSULTAR_TIPO_REVERSION.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultarTipoReversionResponse" location="../../xsds/ConsultarTipoReversion/ConsultarTipoReversion.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/MIDDLEWARE/OSB_CONSULTAR_TIPO_REVERSION/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultarTipoReversionTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultarTipoReversion/ConsultarTipoReversionOut/";

declare function xf:ConsultarTipoReversionOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultarTipoReversionResponse) {
        <ns0:consultarTipoReversionResponse>
            <ns0:consultarTipoReversionResponseType>
                {
                	let $REVERSAL_TYPES := $outputParameters/ns1:TIPOS_REVERSIONES/ns1:ITEM
                	let $DESCRIPTIONS := $outputParameters/ns1:DESCRIPCIONES/ns1:ITEM
                	let $ADDITIONALS_INFO := $outputParameters/ns1:INFORMACION_ADICIONALES/ns1:ITEM
                	return
                    	for $i in 1 to count($REVERSAL_TYPES)
                    		return
	                        <ns0:consultarTipoReversionResponseRecordType>
	                            <REVERSAL_TYPE>{ data($REVERSAL_TYPES[$i]) }</REVERSAL_TYPE>
	                            <DESCRIPTION>{ data($DESCRIPTIONS[$i]) }</DESCRIPTION>
	                            <ADDITIONAL_INFO>{ data($ADDITIONALS_INFO[$i]) }</ADDITIONAL_INFO>
	                        </ns0:consultarTipoReversionResponseRecordType>
                }
            </ns0:consultarTipoReversionResponseType>
        </ns0:consultarTipoReversionResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:ConsultarTipoReversionOut($outputParameters)