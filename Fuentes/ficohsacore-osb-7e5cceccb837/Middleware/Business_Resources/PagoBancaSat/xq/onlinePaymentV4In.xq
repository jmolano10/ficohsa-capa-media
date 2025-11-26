(:: pragma bea:global-element-parameter parameter="$pagoBancaSatRequest" element="ns0:pagoBancaSatRequest" location="../xsd/pagoBancaSatTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../v2/BusinessServices/MasterDataGT/conOrgSequence/xsd/osbConOrgSequence_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:OnlinePaymentV4Request" location="../../../v2/BusinessServices/VisionPlusGT/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoBancaSatTypes";
declare namespace ns2 = "http://www.procesa.com/fdcs/ot";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConOrgSequence";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoBancaSat/xq/onlinePaymentV4In/";

declare function xf:onlinePaymentV4In($pagoBancaSatRequest as element(ns0:pagoBancaSatRequest),
    $outputParameters as element(ns1:OutputParameters),
    $requestType as xs:string,
    $refereciaConsumo as xs:string,
    $referenceMerchant as xs:string)
    as element(ns2:OnlinePaymentV4Request) {
        <ns2:OnlinePaymentV4Request>
            <POSUserData>ATX</POSUserData>
            <RRN37>{ $refereciaConsumo }</RRN37>
            <NumberOfInstallments>00</NumberOfInstallments>
            <MCCType>0000</MCCType>
            <RequestType>{ $requestType }</RequestType>
            <CardNumber>{ data($pagoBancaSatRequest/CREDIT_CARD_PAYMENT_INFO/CREDIT_CARD) }</CardNumber>
            <OrgId>{ data($outputParameters/ns1:ORG) }</OrgId>
            <MerchantNumber>{$referenceMerchant}</MerchantNumber>
            <CardExpirationDate>{ data($pagoBancaSatRequest/CREDIT_CARD_PAYMENT_INFO/EXPIRATION_DATE) }</CardExpirationDate>
            <TotalSalesAmount>{ data($pagoBancaSatRequest/PAYMENT_AMOUNT) }</TotalSalesAmount>
            <Track2Length>0000</Track2Length>
            <Track2Data>0000</Track2Data>
            <CardValidationValue>000</CardValidationValue>
        </ns2:OnlinePaymentV4Request>
};

declare variable $pagoBancaSatRequest as element(ns0:pagoBancaSatRequest) external;
declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $requestType as xs:string external;
declare variable $refereciaConsumo as xs:string external;
declare variable $referenceMerchant as xs:string external;

xf:onlinePaymentV4In($pagoBancaSatRequest,
    $outputParameters,
    $requestType,
    $refereciaConsumo,
    $referenceMerchant)
