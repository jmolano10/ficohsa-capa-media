xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ConsultaSaldosTarjetaCredito" location="../../../BusinessServices/ConsultaSaldosTarjetaCredito/wsdl/ConsultaSaldosTarjetaCreditoService_v2.svc.singleWsdl.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/Core.Entities";
declare namespace ns1 = "http://schemas.datacontract.org/2004/07/Business.Entities";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTarjetaCreditoIn/";

declare function xf:consultaSaldosTarjetaCreditoIn($cardNumber as xs:string,
    $org as xs:string,
    $country as xs:string)
    as element(ns0:ConsultaSaldosTarjetaCredito) {
        <ns0:ConsultaSaldosTarjetaCredito>
            <ns0:request>
                <ns1:ConsultaSaldosTarjetaCreditoRequest>
                    <ns1:CardNumber>{ $cardNumber }</ns1:CardNumber>
                    <ns1:Organizacion>{ $org }</ns1:Organizacion>
                </ns1:ConsultaSaldosTarjetaCreditoRequest>
                <ns1:MensajeEntradaInfo>
                    <ns2:Pais>{ $country }</ns2:Pais>
                </ns1:MensajeEntradaInfo>
            </ns0:request>
        </ns0:ConsultaSaldosTarjetaCredito>
};

declare variable $cardNumber as xs:string external;
declare variable $org as xs:string external;
declare variable $country as xs:string external;

xf:consultaSaldosTarjetaCreditoIn($cardNumber,
    $org,
    $country)