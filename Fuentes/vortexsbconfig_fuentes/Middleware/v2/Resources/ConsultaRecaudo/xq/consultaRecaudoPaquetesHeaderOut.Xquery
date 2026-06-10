<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPaquetesMovilesResponse" element="ns1:ConsultaPaquetesMovilesResponse" location="../../../BusinessServices/T24/PaquetesMoviles/xsd/XMLSchema_-578407725.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PaquetesMoviles/xq/consultaRecaudoPaquetesHeaderOut/";

declare function xf:consultaRecaudoPaquetesHeaderOut($consultaPaquetesMovilesResponse as element(ns1:ConsultaPaquetesMovilesResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $successIndicator in $consultaPaquetesMovilesResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultaPaquetesMovilesResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $consultaPaquetesMovilesResponse as element(ns1:ConsultaPaquetesMovilesResponse) external;

xf:consultaRecaudoPaquetesHeaderOut($consultaPaquetesMovilesResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/T24/PaquetesMoviles/xsd/XMLSchema_-578407725.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/T24/PaquetesMoviles/xsd/XMLSchema_-578407725"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>