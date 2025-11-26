(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../xsds/ConsultaNombreTransaccion/consultarNombreTransaccionT24/MIDDLEWARE_OSB_CONSULTAR_TRANSACCION_MISC.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaNombreTransaccionResponse" location="../../xsds/ConsultaNombreTransaccion/ConsultaNombreTransaccion.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/MIDDLEWARE/OSB_CONSULTAR_TRANSACCION_MISC/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaNombreTransaccionTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaNombreTransaccion/ConsultaNombreTransaccionOut/";

declare function xf:ConsultaNombreTransaccionOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaNombreTransaccionResponse) {
        <ns0:consultaNombreTransaccionResponse>
            <ns0:consultaNombreTransaccionResponseType>
                {
                	let $ID_TRANSACTIONS := $outputParameters/ns1:ID_TRANSACCIONES/ns1:ITEM
                	let $DESCRIPTIONS := $outputParameters/ns1:DESCRIPCIONES/ns1:ITEM
                	let $ADDITIONALS_INFO := $outputParameters/ns1:INFORMACION_ADICIONALES/ns1:ITEM
                	return
                    	for $i in 1 to count($ID_TRANSACTIONS)
                    		return
	                        <ns0:consultaNombreTransaccionResponseRecordType>
	                            <TRANSACTION_ID>{ data($ID_TRANSACTIONS[$i]) }</TRANSACTION_ID>
	                            <DESCRIPTION>{ data($DESCRIPTIONS[$i]) }</DESCRIPTION>
	                            <ADDITIONAL_INFO>{ data($ADDITIONALS_INFO[$i]) }</ADDITIONAL_INFO>
	                        </ns0:consultaNombreTransaccionResponseRecordType>
                }
            </ns0:consultaNombreTransaccionResponseType>
        </ns0:consultaNombreTransaccionResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:ConsultaNombreTransaccionOut($outputParameters)