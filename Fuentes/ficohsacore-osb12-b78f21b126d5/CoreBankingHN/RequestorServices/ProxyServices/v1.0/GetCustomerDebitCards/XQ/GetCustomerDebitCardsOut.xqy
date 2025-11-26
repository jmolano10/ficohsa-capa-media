xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerDebitCards/XMLSchema_-155258746.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/consultaTDCliente";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/getCustomerDebitCards.xsd" ::)

declare namespace ns1="http://www.fichosa.com/midleware.services/GetCustomerDebitCardsOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $ConsultaMaestraTarjetaDebitoResponse as element() (:: schema-element(ns2:ConsultaMaestraTarjetaDebitoResponse) ::) external;
declare variable $uuid as xs:string external;
declare variable $customerId as xs:string external;

declare function ns1:getCustomerDebitCardsOut($uuid as xs:string,
                                              $customerId as xs:string,
                                              $ConsultaMaestraTarjetaDebitoResponse as element() (:: schema-element(ns2:ConsultaMaestraTarjetaDebitoResponse) ::)) as element() (:: schema-element(ns3:getCustomerDebitCardsResponse) ::) {
    <ns3:getCustomerDebitCardsResponse>
        <ns3:StatusInfo>
            {
                if (fn:data($ConsultaMaestraTarjetaDebitoResponse/WSFICODEBITCARDCUSTOMERType/ZERORECORDS)!='')
                then <com:Status>NO RECORDS</com:Status>
                else
                if ($ConsultaMaestraTarjetaDebitoResponse/Status/successIndicator)
                then <com:Status>{fn:data($ConsultaMaestraTarjetaDebitoResponse/Status/successIndicator)}</com:Status>
                else ()
            }
            {
                if ($ConsultaMaestraTarjetaDebitoResponse/Status/transactionId)
                then <com:TransactionId>{fn:data($ConsultaMaestraTarjetaDebitoResponse/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        <ns3:CustomerId>{fn:data($customerId)}</ns3:CustomerId>
        {
            for $mWSFICODEBITCARDCUSTOMERDetailType in $ConsultaMaestraTarjetaDebitoResponse/WSFICODEBITCARDCUSTOMERType/gWSFICODEBITCARDCUSTOMERDetailType/mWSFICODEBITCARDCUSTOMERDetailType
            return 
            <ns3:DebitCards>
                {
                    if ($mWSFICODEBITCARDCUSTOMERDetailType/CARDNUMBER)
                    then <ns3:CardNumber>{fn:data($mWSFICODEBITCARDCUSTOMERDetailType/CARDNUMBER)}</ns3:CardNumber>
                    else ()
                }
                {
                    if ($mWSFICODEBITCARDCUSTOMERDetailType/NAMEONCARD)
                    then <ns3:CardHolderName>{fn:data($mWSFICODEBITCARDCUSTOMERDetailType/NAMEONCARD)}</ns3:CardHolderName>
                    else ()
                }
                {
                    if ($mWSFICODEBITCARDCUSTOMERDetailType/TYPEOFCARD)
                    then <ns3:Category>{fn:data($mWSFICODEBITCARDCUSTOMERDetailType/TYPEOFCARD)}</ns3:Category>
                    else ()
                }
                {
                    if ($mWSFICODEBITCARDCUSTOMERDetailType/PRODUCTTYPE)
                    then <ns3:Type>{fn:data($mWSFICODEBITCARDCUSTOMERDetailType/PRODUCTTYPE)}</ns3:Type>
                    else ()
                }
                {
                    if ($mWSFICODEBITCARDCUSTOMERDetailType/ISSUEDATE)
                    then <ns3:IssuedDate>
                    {
                      fn:concat(fn:substring(fn:data($mWSFICODEBITCARDCUSTOMERDetailType/ISSUEDATE),0,5),'-',fn:substring(fn:data($mWSFICODEBITCARDCUSTOMERDetailType/ISSUEDATE),5,2),'-',fn:substring(fn:data($mWSFICODEBITCARDCUSTOMERDetailType/ISSUEDATE),7,2))
                     }
                    </ns3:IssuedDate>
                    
                    else ()
                }
                {
                    if ($mWSFICODEBITCARDCUSTOMERDetailType/PRIMARYACCT)
                    then <ns3:PrimaryAccount>{fn:data($mWSFICODEBITCARDCUSTOMERDetailType/PRIMARYACCT)}</ns3:PrimaryAccount>
                    else ()
                }
                {
                    if ($mWSFICODEBITCARDCUSTOMERDetailType/CURRENCY1)
                    then <ns3:PrimaryAccountCurrency>{fn:data($mWSFICODEBITCARDCUSTOMERDetailType/CURRENCY1)}</ns3:PrimaryAccountCurrency>
                    else ()
                }
            </ns3:DebitCards>
        }
    </ns3:getCustomerDebitCardsResponse>
};

ns1:getCustomerDebitCardsOut($uuid, $customerId, $ConsultaMaestraTarjetaDebitoResponse)