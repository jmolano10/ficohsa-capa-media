<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$embosserAddL8VGResponse1" element="ns1:EmbosserAddL8VGResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns0:solicitudTCResponse" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudTC/xq/solicitudTCHNOut/";

declare function xf:solicitudTCHNOut($embosserAddL8VGResponse1 as element(ns1:EmbosserAddL8VGResponse))
    as element(ns0:solicitudTCResponse) {
        <ns0:solicitudTCResponse>
            <LCY_ORG>{ data($embosserAddL8VGResponse1/AZXAPO-ORG) }</LCY_ORG>
            <FCY_ORG>{ data($embosserAddL8VGResponse1/AZXAPO-FOREIGN-ORG) }</FCY_ORG>
            <LOGO>{ data($embosserAddL8VGResponse1/AZXAPO-LOGO) }</LOGO>
            <ACCOUNT_NUMBER>{ data($embosserAddL8VGResponse1/AZXAPO-ACCT) }</ACCOUNT_NUMBER>
            <CARD_NUMBER>{ data($embosserAddL8VGResponse1/AZXAPO-CARD-NBR) }</CARD_NUMBER>
            <CARD_SEQUENCE>{ data($embosserAddL8VGResponse1/AZXAPO-CARD-SEQ) }</CARD_SEQUENCE>
            <CHIP_SEQUENCE>{ data($embosserAddL8VGResponse1/AZXAPO-CURR-CHIP-SEQ) }</CHIP_SEQUENCE>
        </ns0:solicitudTCResponse>
};

declare variable $embosserAddL8VGResponse1 as element(ns1:EmbosserAddL8VGResponse) external;

xf:solicitudTCHNOut($embosserAddL8VGResponse1)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616"/>
    </con:dependency>
    <con:dependency location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionesTarjetas/xsd/gestionesTarjetasTypes"/>
    </con:dependency>
</con:xqueryEntry>