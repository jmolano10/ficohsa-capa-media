xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://soap.sforce.com/schemas/class/WS_crearOrdenEmpaque";
(:: import schema at "../../../../../ProviderServices/v1.0/WSDL/PackingOrder/PackingOrder_BS.wsdl" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/debitCardsTypes";
(:: import schema at "../../../../../../MWBanking/DebitCards/RequestorServices/XSD/debitCardsTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/createPackingOrderIn";

declare namespace cus = "http://www.ficohsa.com.hn/middleware.services/customerInfoCommonTypes";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

(: Función encargada de realizar el mapeo de usuario:)
declare function xq:getAddressType ($type as xs:string)  as xs:string { 
	if ($type = 'Home')
        then '1'
        else if ($type = 'Work')
        then '2'
        else if ($type = 'Other')
        then '3'
        else ''
 };

declare variable $packingOrderRequest as element() (:: schema-element(ns2:packingOrderRequest) ::) external;

declare function ns1:createPackingOrderIn($packingOrderRequest as element() (:: schema-element(ns2:packingOrderRequest) ::)) as element() (:: schema-element(ns3:crearOrdenEmpaque) ::) {
    <ns3:crearOrdenEmpaque>
        <ns3:legal_id>{fn:data($packingOrderRequest/ns2:CustomerInfo/ns2:LegalId)}</ns3:legal_id>
        <ns3:client_name>{fn:data($packingOrderRequest/ns2:CustomerInfo/ns2:Name)}</ns3:client_name>
        <ns3:customer_id>{fn:data($packingOrderRequest/ns2:CustomerInfo/ns2:Code)}</ns3:customer_id>
        <ns3:account_number>{fn:data($packingOrderRequest/ns2:AccountInfo/ns2:AccountNumber)}</ns3:account_number>
        <ns3:email_address>{fn:data($packingOrderRequest/ns2:CustomerInfo/ns2:Email)}</ns3:email_address>
        {
            for $PhoneInfo in $packingOrderRequest/ns2:PhoneInfo
            return 
            <ns3:phone_info>
                <ns3:phone_number>{fn:data($PhoneInfo/cus:PhoneNumber)}</ns3:phone_number>
                <ns3:phone_type>{fn:data($PhoneInfo/cus:Type)}</ns3:phone_type></ns3:phone_info>
        }
        {
            for $AddressInfo in $packingOrderRequest/ns2:AddressInfo
            return 
            <ns3:address_info>
                <ns3:address_line>{fn:data($AddressInfo/ns2:AddressLine)}</ns3:address_line>
                <ns3:address_type>{xq:getAddressType(fn:data($AddressInfo/ns2:Type))}</ns3:address_type>
                <ns3:is_delivery_address>{upper-case(fn:data($AddressInfo/ns2:IsDeliveryAddress))}</ns3:is_delivery_address></ns3:address_info>
        }
        <ns3:job_info>{fn:data($packingOrderRequest/ns2:JobInfo[1]/ns2:JobDescription)}</ns3:job_info>
        <ns3:card_info>
            <ns3:card_currency>{fn:data($packingOrderRequest/ns2:AccountInfo/ns2:AccountCurrency)}</ns3:card_currency>
            {
                if ($packingOrderRequest/ns2:CardInfo/ns2:LastCardNumber)
                then <ns3:card_number>{fn:data($packingOrderRequest/ns2:CardInfo/ns2:LastCardNumber)}</ns3:card_number>
                else ()
            }
            {
                if ($packingOrderRequest/ns2:CardInfo/ns2:Type)
                then <ns3:product_type>{fn:data($packingOrderRequest/ns2:CardInfo/ns2:Type)}</ns3:product_type>
                else ()
            }
        </ns3:card_info>
        <ns3:agency>{fn:data($packingOrderRequest/ns2:CardInfo/ns2:BranchCode)}</ns3:agency>
    </ns3:crearOrdenEmpaque>
};

ns1:createPackingOrderIn($packingOrderRequest)
