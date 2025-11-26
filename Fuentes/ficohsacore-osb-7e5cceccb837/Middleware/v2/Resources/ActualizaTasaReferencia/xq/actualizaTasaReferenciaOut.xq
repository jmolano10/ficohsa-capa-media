(:: pragma bea:global-element-parameter parameter="$updateResponse" element="ns1:UpdateResponse" location="../../../BusinessServices/FX/actualizaTasaReferencia/wsdl/exchangerate.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:actualizaTasaReferenciaResponse" location="../xsd/actualizaTasaReferenciaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaTasaReferenciaTypes";
declare namespace ns1 = "http://ficohsa.fx.webservices/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaTasaReferencia/xq/actualizaTasaReferenciaOut/";

declare function xf:actualizaTasaReferenciaOut($updateResponse as element(ns1:UpdateResponse))
    as element(ns0:actualizaTasaReferenciaResponse) {
        <ns0:actualizaTasaReferenciaResponse>
            <COUNTRY>{ data($updateResponse/ns1:UpdateResult/ns1:Country) }</COUNTRY>
            <RATE>{ data($updateResponse/ns1:UpdateResult/ns1:Rate) }</RATE>
            <SOURCE_CURRENCY>{ data($updateResponse/ns1:UpdateResult/ns1:SourceCurrency) }</SOURCE_CURRENCY>
            <TARGET_CURRENCY>{ data($updateResponse/ns1:UpdateResult/ns1:TargetCurrency) }</TARGET_CURRENCY>
        </ns0:actualizaTasaReferenciaResponse>
};

declare variable $updateResponse as element(ns1:UpdateResponse) external;

xf:actualizaTasaReferenciaOut($updateResponse)