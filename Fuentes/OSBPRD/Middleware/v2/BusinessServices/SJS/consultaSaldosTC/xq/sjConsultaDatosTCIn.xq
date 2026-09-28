xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosTC1" element="ns2:sjConsultaSaldosTC" location="../xsd/sjConsultaSaldosTC.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InformacionTarjeta" location="../../../../../Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSaldosTC/xq/sjConsultaDatosTCIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTC";
declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://tempuri2.org/";

declare function xf:sjConsultaDatosTCIn($sjConsultaSaldosTC1 as element(ns2:sjConsultaSaldosTC))
    as element(ns1:InformacionTarjeta) {
        <ns1:InformacionTarjeta>
        	<ns1:noTarjetaCredito>{ data($sjConsultaSaldosTC1/CARD_NUMBER) }</ns1:noTarjetaCredito>
        </ns1:InformacionTarjeta>
};

declare variable $sjConsultaSaldosTC1 as element(ns2:sjConsultaSaldosTC) external;

xf:sjConsultaDatosTCIn($sjConsultaSaldosTC1)