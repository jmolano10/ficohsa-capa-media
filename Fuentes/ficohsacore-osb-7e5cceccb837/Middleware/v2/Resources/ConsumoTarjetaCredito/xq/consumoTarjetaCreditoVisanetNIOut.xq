xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$authorizationResponse" element="ns0:AuthorizationResponse" location="../../../BusinessServices/VisaNet/wsdl/paymentcommerce_1.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:consumoTarjetaCreditoResponse" location="../../PuntoVentaVirtual/xsd/PuntoVentaVirtualTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsumoTarjetaCredito/xq/consumoTarjetaCreditoVisanetNIOut/";
declare namespace ns0 = "http://general_computing.com/paymentgw/types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/puntoVentaVirtualTypes";

declare function xf:consumoTarjetaCreditoVisanetNIOut($authorizationResponse as element(ns0:AuthorizationResponse),
    $creditCard as xs:string)
    as element(ns1:consumoTarjetaCreditoResponse) {
        <ns1:consumoTarjetaCreditoResponse>
            <CREDIT_CARD_NUMBER>{ $creditCard }</CREDIT_CARD_NUMBER>
            <TRANSACTION_DATE>{fn-bea:date-to-string-with-format("yyyyMMdd", fn:adjust-date-to-timezone(fn:current-date(), ())) }</TRANSACTION_DATE>
            <AUTHORIZATION_NUMBER>{ data($authorizationResponse/ns0:response/ns0:authorizationNumber) }</AUTHORIZATION_NUMBER>
            <ns1:REFERENCES>
                {
                    for $referenceNumber in $authorizationResponse/ns0:response/ns0:referenceNumber
                    return
                        <REFERENCE>
                            <SOURCE>AUTHORIZER</SOURCE>
                            {
                                for $referenceNumber0 in $referenceNumber
                                return
                                    <VALUE>{ data($referenceNumber0) }</VALUE>
                            }
                        </REFERENCE>
                }
                {
                    for $auditNumber in $authorizationResponse/ns0:response/ns0:auditNumber
                    return
                        <REFERENCE>
                            <SOURCE>CHANNEL</SOURCE>
                            {
                                for $auditNumber0 in $auditNumber
                                return
                                    <VALUE>{ data($auditNumber0) }</VALUE>
                            }
                        </REFERENCE>
                }
                
            </ns1:REFERENCES>
        </ns1:consumoTarjetaCreditoResponse>
};

declare variable $authorizationResponse as element(ns0:AuthorizationResponse) external;
declare variable $creditCard as xs:string external;

xf:consumoTarjetaCreditoVisanetNIOut($authorizationResponse,
    $creditCard)