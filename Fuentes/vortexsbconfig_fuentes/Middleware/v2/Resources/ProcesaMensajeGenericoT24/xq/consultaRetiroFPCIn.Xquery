<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/FPC/consultaRetiroFPC/xsd/CONSULTA_RETIRO_FPC_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CONSULTA_RETIRO_FPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaRetiroFPCIn/";

declare function xf:consultaRetiroFPCIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
	            let $messageList := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
	            return (
		            <ns1:P_NUM_SOLICITUD>{ $messageList[2] }</ns1:P_NUM_SOLICITUD>,
		            <ns1:P_ID_CLIENTE>{ $messageList[1] }</ns1:P_ID_CLIENTE>
		        )
	        }
        </ns1:InputParameters>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:consultaRetiroFPCIn($procesaMensajeGenericoT24)]]></con:xquery>
    <con:dependency location="../xsd/procesaMensajeGenericoT24Types.xsd">
        <con:schema ref="Middleware/v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/FPC/consultaRetiroFPC/xsd/CONSULTA_RETIRO_FPC_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/FPC/consultaRetiroFPC/xsd/CONSULTA_RETIRO_FPC_sp"/>
    </con:dependency>
</con:xqueryEntry>