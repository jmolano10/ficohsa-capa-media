xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$authorizationResponse" element="ns0:AuthorizationResponse" location="../../../BusinessServices/VisaNet/wsdl/paymentcommerce_1.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:reversaConsumoTarjetaCreditoResponse" location="../../PuntoVentaVirtual/xsd/PuntoVentaVirtualTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaConsumoTarjetaCredito/xq/reversaConsumoTarjetaCreditoVisanetNIOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/puntoVentaVirtualTypes";
declare namespace ns0 = "http://general_computing.com/paymentgw/types";

declare function xf:reversaConsumoTarjetaCreditoVisanetNIOut($authorizationResponse as element(ns0:AuthorizationResponse),
    $creditCard as xs:string)as element(ns1:reversaConsumoTarjetaCreditoResponse) {
       <ns1:reversaConsumoTarjetaCreditoResponse>
            <CREDIT_CARD_NUMBER>{ $creditCard }</CREDIT_CARD_NUMBER>
            <TRANSACTION_DATE>{ fn-bea:date-to-string-with-format("yyyyMMdd", fn:adjust-date-to-timezone(fn:current-date(), ())) }</TRANSACTION_DATE>
            <AUTHORIZATION_NUMBER>{ data($authorizationResponse/ns0:response/ns0:authorizationNumber) }</AUTHORIZATION_NUMBER>
            <REFERENCES>
                {
                    for $referenceNumber in $authorizationResponse/ns0:response/ns0:referenceNumber
                    return
                        <REFERENCE>
                            <SOURCE>VISANET</SOURCE>
                            {
                                for $referenceNumberItem in $referenceNumber
                                return
                                    <VALUE>{ data($referenceNumberItem) }</VALUE>
                            }
                        </REFERENCE>
                }
                {
                    for $auditNumber in $authorizationResponse/ns0:response/ns0:auditNumber
                    return
                        <REFERENCE>
                            <SOURCE>BANK</SOURCE>
                            {
                                for $auditNumberItem in $auditNumber
                                return
                                    <VALUE>{ data($auditNumberItem) }</VALUE>
                            }
                        </REFERENCE>
                }
            </REFERENCES>
        </ns1:reversaConsumoTarjetaCreditoResponse>

};

declare variable $authorizationResponse as element(ns0:AuthorizationResponse) external;
declare variable $creditCard as xs:string external;
xf:reversaConsumoTarjetaCreditoVisanetNIOut($authorizationResponse,
$creditCard)