xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito1" element="ns0:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:OnlinePaymentV4Request" location="../../../BusinessServices/VisionPlusPA/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs/ot";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/onlinePaymentV4ReversaIn/";

declare function xf:onlinePaymentV4ReversaIn($retiroTarjetaCredito1 as element(ns0:retiroTarjetaCredito),
    $org as xs:string,
    $rrn37 as xs:string,
    $merchantNumber as xs:string)
    as element(ns1:OnlinePaymentV4Request) {
        <ns1:OnlinePaymentV4Request>
            <POSUserData>ATX</POSUserData>
            <RRN37>{ data($rrn37) }</RRN37>
            <NumberOfInstallments>00</NumberOfInstallments>
            <MCCType>6010</MCCType>
            <RequestType>R</RequestType>
            <CardNumber>{ data($retiroTarjetaCredito1/CREDIT_CARD_INFO/VALUE) }</CardNumber>
            <OrgId>{ data($org) }</OrgId>
            <MerchantNumber>{$merchantNumber}</MerchantNumber>
            <CardExpirationDate>0000</CardExpirationDate>
            <TotalSalesAmount>{ data($retiroTarjetaCredito1/AMOUNT) }</TotalSalesAmount>
            <Track2Length>0000</Track2Length>
            <Track2Data>0000</Track2Data>
            <CardValidationValue>000</CardValidationValue>
        </ns1:OnlinePaymentV4Request>
};

declare variable $retiroTarjetaCredito1 as element(ns0:retiroTarjetaCredito) external;
declare variable $org as xs:string external;
declare variable $rrn37 as xs:string external;
declare variable $merchantNumber as xs:string external;

xf:onlinePaymentV4ReversaIn($retiroTarjetaCredito1,
    $org,
    $rrn37,
    $merchantNumber)