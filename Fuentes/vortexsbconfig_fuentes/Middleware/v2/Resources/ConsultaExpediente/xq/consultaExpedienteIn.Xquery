<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaExpediente" element="ns1:consultaExpediente" location="../../DigitalizacionExpediente/xsd/digitalizacionExpedienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:BuscarExpediente" location="../../../BusinessServices/TotalImage/totalImage/wsdl/TotalImageWS.wsdl" ::)

declare namespace ns0 = "http://interfase.bpm.sitecpro.com/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionExpedienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaExpediente/xq/consultaExpedienteIn/";

declare function xf:consultaExpedienteIn($consultaExpediente as element(ns1:consultaExpediente), $parameter as xs:string)
    as element(ns0:BuscarExpediente) {
        <ns0:BuscarExpediente>
            <ns0:TpExp>{ data($consultaExpediente/FILE_TYPE_NAME) }</ns0:TpExp>
            <ns0:LlavesExpNomb>
            {
                   fn:string-join(for $llaveExpNom in $consultaExpediente/KEY_INFO/ITEM/KEY
                   return $llaveExpNom, $parameter)
            }
            </ns0:LlavesExpNomb>
            <ns0:LlavesExpVal>
            {
                   fn:string-join(for $llaveExpVal in $consultaExpediente/KEY_INFO/ITEM/VALUE
                   return $llaveExpVal, $parameter)
            }
            </ns0:LlavesExpVal>
        </ns0:BuscarExpediente>
};

declare variable $consultaExpediente as element(ns1:consultaExpediente) external;
declare variable $parameter as xs:string external;

xf:consultaExpedienteIn($consultaExpediente,$parameter)]]></con:xquery>
    <con:dependency location="../../DigitalizacionExpediente/xsd/digitalizacionExpedienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/DigitalizacionExpediente/xsd/digitalizacionExpedienteTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/TotalImage/totalImage/wsdl/TotalImageWS.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/TotalImage/totalImage/wsdl/TotalImageWS"/>
    </con:dependency>
</con:xqueryEntry>