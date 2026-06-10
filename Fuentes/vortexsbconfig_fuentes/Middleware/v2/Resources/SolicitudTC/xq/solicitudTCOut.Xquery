<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:solicitudTCResponse" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$embosserAddL8VBResponse" element="ns1:EmbosserAddL8VBResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudTC/xq/solicitudTCOut/";

declare function xf:solicitudTCOut($embosserAddL8VBResponse as element(ns1:EmbosserAddL8VBResponse))
    as element(ns0:solicitudTCResponse) {
        <ns0:solicitudTCResponse>
            <LCY_ORG>{ data($embosserAddL8VBResponse/AZXAPO-ORG) }</LCY_ORG>
            <FCY_ORG>{ data($embosserAddL8VBResponse/AZXAPO-FOREIGN-ORG) }</FCY_ORG>
            <LOGO>{ data($embosserAddL8VBResponse/AZXAPO-LOGO) }</LOGO>
            <ACCOUNT_NUMBER>{ data($embosserAddL8VBResponse/AZXAPO-ACCT) }</ACCOUNT_NUMBER>
            <CARD_NUMBER>{ data($embosserAddL8VBResponse/AZXAPO-CARD-NBR) }</CARD_NUMBER>
            <CARD_SEQUENCE>{ data($embosserAddL8VBResponse/AZXAPO-CARD-SEQ) }</CARD_SEQUENCE>
            <CHIP_SEQUENCE>{ data($embosserAddL8VBResponse/AZXAPO-CURR-CHIP-SEQ) }</CHIP_SEQUENCE>
        </ns0:solicitudTCResponse>
};

declare variable $embosserAddL8VBResponse as element(ns1:EmbosserAddL8VBResponse) external;

xf:solicitudTCOut($embosserAddL8VBResponse)]]></con:xquery>
    <con:dependency location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionesTarjetas/xsd/gestionesTarjetasTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616"/>
    </con:dependency>
</con:xqueryEntry>