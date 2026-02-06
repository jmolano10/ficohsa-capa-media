xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjPagoMultipleRecaudo" element="ns1:sjPagoMultipleRecaudo" location="../xsd/sjPagoMultipleRecaudo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjPagoMultipleRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/pagoMultipleRecaudo/xq/pagoRecaudoHeaderIn/";

declare function xf:pagoRecaudoHeaderIn($sjPagoMultipleRecaudo as element(ns1:sjPagoMultipleRecaudo))
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>
                <UserName>{ data($sjPagoMultipleRecaudo/USERNAME) }</UserName>
                <Password>{ data($sjPagoMultipleRecaudo/PASSWORD) }</Password>
            </Authentication>
            <Region>
                <SourceBank>{ data($sjPagoMultipleRecaudo/SOURCE_BANK) }</SourceBank>
                <DestinationBank>{ data($sjPagoMultipleRecaudo/DESTINATION_BANK) }</DestinationBank>
            </Region>
        </ns0:RequestHeader>
};

declare variable $sjPagoMultipleRecaudo as element(ns1:sjPagoMultipleRecaudo) external;

xf:pagoRecaudoHeaderIn($sjPagoMultipleRecaudo)