(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/PWS/registraTramaEventoT24/xsd/registraTramaEventoT24_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:notificaEventosT24Response" location="../xsd/notificaEventosT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEventosT24Types";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraTramaEventoT24_db";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEventosT24/xq/registraTramaEventosT24Out/";

declare function xf:registraTramaEventosT24Out($outputParameters as element(ns1:OutputParameters))
    as element(ns0:notificaEventosT24Response) {
        <ns0:notificaEventosT24Response>
            <EVENTS>
                {
                    for $P_EVENTO_T24_ITEM in $outputParameters/ns1:P_EVENTO_T24/ns1:P_EVENTO_T24_ITEM
                    return
                        <EVENT>
                            <FIELDS>
                                {
                                    for $VALOR_TRAMA_ITEM in $P_EVENTO_T24_ITEM/ns1:VALOR_TRAMA/ns1:VALOR_TRAMA_ITEM
                                    return
                                        <FIELD>
                                            {
                                                for $NOMBRE_TRAMA in $VALOR_TRAMA_ITEM/ns1:NOMBRE_TRAMA
                                                return
                                                    <TYPE_NAME>{ data($NOMBRE_TRAMA) }</TYPE_NAME>
                                            }
                                            {
                                                for $VALOR_TRAMA in $VALOR_TRAMA_ITEM/ns1:VALOR_TRAMA
                                                return
                                                    <TYPE_VALUE>{ data($VALOR_TRAMA) }</TYPE_VALUE>
                                            }
                                        </FIELD>
                                }
                            </FIELDS>
                            {
                                for $CODIGO_MENSAJE in $P_EVENTO_T24_ITEM/ns1:CODIGO_MENSAJE
                                return
                                    <SUCCESS_INDICATOR>{ data($CODIGO_MENSAJE) }</SUCCESS_INDICATOR>
                            }
                            {
                                for $DESCRIPCION_MENSAJE in $P_EVENTO_T24_ITEM/ns1:DESCRIPCION_MENSAJE
                                return
                                    if(string($DESCRIPCION_MENSAJE) != '')then(
                                    		<ERROR_MESSAGE>{ data($DESCRIPCION_MENSAJE) }</ERROR_MESSAGE>
                                    )else()
                            }
                        </EVENT>
                }
            </EVENTS>
        </ns0:notificaEventosT24Response>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:registraTramaEventosT24Out($outputParameters)