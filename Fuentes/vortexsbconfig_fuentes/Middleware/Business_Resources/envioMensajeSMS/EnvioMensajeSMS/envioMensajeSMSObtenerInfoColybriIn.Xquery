<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$envioMensajeSMS" element="ns1:envioMensajeSMS" location="envioMensajeSMSTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/ObtenerInfoColybri/xsd/ORA_BANK_OSB_P_OBTENER_INFO_COLYBRI.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/envioMensajeSMSTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_P_OBTENER_INFO_COLYBRI/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/envioMensajeSMS/EnvioMensajeSMS/envioMensajeSMSObtenerInfoColybriIn/";

declare function xf:envioMensajeSMSObtenerInfoColybriIn($envioMensajeSMS as element(ns1:envioMensajeSMS))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:MOBILE_NUMBER>{ data($envioMensajeSMS/MOBILE_NUMBER) }</ns0:MOBILE_NUMBER>
            <ns0:MESSAGE_TYPE>{ data($envioMensajeSMS/MESSAGE_TYPE) }</ns0:MESSAGE_TYPE>
            <ns0:SERVICE>{ data($envioMensajeSMS/SERVICE) }</ns0:SERVICE>
        </ns0:InputParameters>
};

declare variable $envioMensajeSMS as element(ns1:envioMensajeSMS) external;

xf:envioMensajeSMSObtenerInfoColybriIn($envioMensajeSMS)]]></con:xquery>
    <con:dependency location="envioMensajeSMSTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/envioMensajeSMS/EnvioMensajeSMS/envioMensajeSMSTypes"/>
    </con:dependency>
    <con:dependency location="../Resources/ObtenerInfoColybri/xsd/ORA_BANK_OSB_P_OBTENER_INFO_COLYBRI.xsd">
        <con:schema ref="Middleware/Business_Resources/envioMensajeSMS/Resources/ObtenerInfoColybri/xsd/ORA_BANK_OSB_P_OBTENER_INFO_COLYBRI"/>
    </con:dependency>
</con:xqueryEntry>