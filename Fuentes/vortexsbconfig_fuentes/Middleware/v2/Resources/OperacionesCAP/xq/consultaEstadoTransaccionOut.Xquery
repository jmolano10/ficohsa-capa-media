<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaEstadoTransaccionResponse" element="ns0:ConsultaEstadoTransaccionResponse" location="../../../BusinessServices/T24/svcConsultaEstadoTransaccion/xsd/svcConsultaEstadoTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaEstadoTransferenciaCAPResponse" location="../xsd/operacionesCAPTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/consultaEstadoTransaccionOut/";

declare function xf:consultaEstadoTransaccionOut($consultaEstadoTransaccionResponse as element(ns0:ConsultaEstadoTransaccionResponse))
    as element(ns1:consultaEstadoTransferenciaCAPResponse) {
    let $refT24 := data($consultaEstadoTransaccionResponse/WSFICOCONSULTATRXTENGOType[1]/gWSFICOCONSULTATRXTENGODetailType/mWSFICOCONSULTATRXTENGODetailType[1]/REFT24)
	return(        
        <ns1:consultaEstadoTransferenciaCAPResponse>
            <CORE_REFERENCE>{ $refT24 }</CORE_REFERENCE>
            <TRANSACTION_STATUS>
            { 
            	if(fn:normalize-space($refT24) != '')then
            		"EXITOSA"
            	else
            		"FALLIDA"
            }
            </TRANSACTION_STATUS>
        </ns1:consultaEstadoTransferenciaCAPResponse>
        )
};

declare variable $consultaEstadoTransaccionResponse as element(ns0:ConsultaEstadoTransaccionResponse) external;

xf:consultaEstadoTransaccionOut($consultaEstadoTransaccionResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/T24/svcConsultaEstadoTransaccion/xsd/svcConsultaEstadoTransaccionTypes.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/T24/svcConsultaEstadoTransaccion/xsd/svcConsultaEstadoTransaccionTypes"/>
    </con:dependency>
    <con:dependency location="../xsd/operacionesCAPTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesCAP/xsd/operacionesCAPTypes"/>
    </con:dependency>
</con:xqueryEntry>