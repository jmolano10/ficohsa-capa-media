<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma  parameter="$details" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:notificaDivisasResponse" location="../xsd/notificaDivisasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaDivisasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaDivisas/xq/notificaDivisasOut/";

declare function xf:notificaDivisasOut($details as element(*))
    as element(ns0:notificaDivisasResponse) {
        <ns0:notificaDivisasResponse>
            <DATE>{ data($details/fecha) }</DATE>
            <ENTITY>{ data($details/entidad) }</ENTITY>
            <CORRELATIVE>{ data($details/correlativo) }</CORRELATIVE>
        </ns0:notificaDivisasResponse>
};

declare variable $details as element(*) external;

xf:notificaDivisasOut($details)]]></con:xquery>
    <con:dependency location="../xsd/notificaDivisasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/NotificaDivisas/xsd/notificaDivisasTypes"/>
    </con:dependency>
</con:xqueryEntry>