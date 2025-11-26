(:: pragma bea:global-element-parameter parameter="$actualizaTasaReferencia" element="ns0:actualizaTasaReferencia" location="../xsd/actualizaTasaReferenciaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Update" location="../../../BusinessServices/FX/actualizaTasaReferencia/wsdl/exchangerate.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaTasaReferenciaTypes";
declare namespace ns1 = "http://ficohsa.fx.webservices/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaTasaReferencia/xq/actualizaTasaReferenciaIn/";

declare function xf:actualizaTasaReferenciaIn($actualizaTasaReferencia as element(ns0:actualizaTasaReferencia))
    as element(ns1:Update) {
        <ns1:Update>
            <ns1:model>
                <ns1:Country>{ data($actualizaTasaReferencia/COUNTRY) }</ns1:Country>
                <ns1:SourceCurrency>{ data($actualizaTasaReferencia/SOURCE_CURRENCY) }</ns1:SourceCurrency>
                <ns1:TargetCurrency>{ data($actualizaTasaReferencia/TARGET_CURRENCY) }</ns1:TargetCurrency>
                <ns1:Rate>{ data($actualizaTasaReferencia/RATE) }</ns1:Rate>
            </ns1:model>
        </ns1:Update>
};

declare variable $actualizaTasaReferencia as element(ns0:actualizaTasaReferencia) external;

xf:actualizaTasaReferenciaIn($actualizaTasaReferencia)