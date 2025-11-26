xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/paquetesTigo";
(:: import schema at "../../../../ProviderServices/WSDL/PaquetesTiggo/paquetesTigo.wsdl" ::)

declare variable $PaymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;
declare variable $Type as xs:string external;
declare variable $EXTNWCODE as xs:string external;
declare variable $MSISDN as xs:string external;
declare variable $EXTCODE as xs:string external;
declare variable $TransactionId as xs:string external;

declare function local:func($PaymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::), 
                            $Type as xs:string, 
                            $EXTNWCODE as xs:string, 
                            $MSISDN as xs:string, 
                            $EXTCODE as xs:string, 
                            $TransactionId as xs:string) 
                            as element() (:: schema-element(ns2:paqueteTigoRequest) ::) {
    <ns2:paqueteTigoRequest>
        <COMMAND>
            <TYPE>{fn:data($Type)}</TYPE>
            <DATE>06/03/2017</DATE>
            <EXTNWCODE>{fn:data($EXTNWCODE)}</EXTNWCODE>
            <MSISDN>{fn:data($MSISDN)}</MSISDN>
            <PIN/>
            <LOGINID/>
            <PASSWORD/>
            <EXTCODE>{fn:data($EXTCODE)}</EXTCODE>
            <EXTREFNUM>{fn:data($TransactionId)}</EXTREFNUM>
            <MSISDN2>{fn:data($PaymentCollectionRequest/ns1:DebtorCode)}</MSISDN2>
            <AMOUNT>{fn:data($PaymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentAmount)}</AMOUNT>
            <SELECTOR>
            {
              if(substring-before(fn:data($PaymentCollectionRequest/ns1:BillInformation/ns1:BillNumber), fn:data(substring-before($PaymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentAmount, "."))) = "") then(
                      substring-before(fn:data($PaymentCollectionRequest/ns1:BillInformation/ns1:BillNumber), fn:data($PaymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentAmount)) 
              )else(
                      substring-before(fn:data($PaymentCollectionRequest/ns1:BillInformation/ns1:BillNumber), fn:data(substring-before($PaymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentAmount, "."))))  
            }
            </SELECTOR>
            <LANGUAGE1/>
            <LANGUAGE2/>
        </COMMAND>
    </ns2:paqueteTigoRequest>
};

local:func($PaymentCollectionRequest, $Type, $EXTNWCODE, $MSISDN, $EXTCODE, $TransactionId)