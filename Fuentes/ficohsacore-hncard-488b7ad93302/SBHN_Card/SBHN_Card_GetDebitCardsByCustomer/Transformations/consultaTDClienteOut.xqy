xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../Schemas/getDebitCardsByCustomer/XMLSchema_-149513020.xsd" ::)
declare namespace ns0="https://www.ficohsa.com/regional/card";
(:: import schema at "../../SBHN_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)

declare variable $consultaMaestraTarjetaDebitoResponse1 as element() (:: schema-element(ns1:getDebitCardsByCustomerResponse) ::) external;
declare variable $globalId as xs:string external;
declare variable $status as xs:string external;

declare function local:format-date($inputDate as xs:string) as xs:string {
if (string-length($inputDate)=8)then(
let $year := substring($inputDate, 1, 4)
  let $month := substring($inputDate, 5, 2)
  let $day := substring($inputDate, 7, 2)
  return concat($year, '-', $month, '-', $day)
)else(
''
)
};

declare function local:func($consultaMaestraTarjetaDebitoResponse1 as element() (:: schema-element(ns1:getDebitCardsByCustomerResponse) ::), 
                            $globalId as xs:string, 
                            $status as xs:string) 
                            as element() (:: schema-element(ns0:getDebitCardsByCustomerResponse) ::) {
    <ns0:getDebitCardsByCustomerResponse>
        <StatusInfo>
            <Status>{fn:data($status)}</Status>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        <CustomerId>{fn:data($consultaMaestraTarjetaDebitoResponse1/WSFICODEBITCARDCUSTOMERType/gWSFICODEBITCARDCUSTOMERDetailType/mWSFICODEBITCARDCUSTOMERDetailType[1]/CUSTOMER)}</CustomerId>
        {
        for $mWSFICODEBITCARDCUSTOMERDetailType in $consultaMaestraTarjetaDebitoResponse1/WSFICODEBITCARDCUSTOMERType[1]/gWSFICODEBITCARDCUSTOMERDetailType/mWSFICODEBITCARDCUSTOMERDetailType
        return
        <DebitCardCustomerRecords>
          {
                                for $CARDNUMBER in $mWSFICODEBITCARDCUSTOMERDetailType/CARDNUMBER
                                return
                                    <CardNumber>{ data($CARDNUMBER) }</CardNumber>
                            }
                            {
                                for $NAMEONCARD in $mWSFICODEBITCARDCUSTOMERDetailType/NAMEONCARD
                                return
                                    <CardHolderName>{ data($NAMEONCARD) }</CardHolderName>
                            }
                            {
                                for $TYPEOFCARD in $mWSFICODEBITCARDCUSTOMERDetailType/TYPEOFCARD
                                return
                                    <CardCategory>{ data($TYPEOFCARD) }</CardCategory>
                            }
                            {
                                for $PRODUCTTYPE in $mWSFICODEBITCARDCUSTOMERDetailType/PRODUCTTYPE
                                return
                                    <CardType>{ data($PRODUCTTYPE) }</CardType>
                            }
                            {
                                for $ISSUEDATE in $mWSFICODEBITCARDCUSTOMERDetailType/ISSUEDATE
                                return
                                   <IssueDate>{ local:format-date(data($ISSUEDATE)) }</IssueDate>
                            }
                            {
                                for $CARDNUMBER in $mWSFICODEBITCARDCUSTOMERDetailType/CARDNUMBER
                                return
                                   if (substring(data($CARDNUMBER), 1,1) = '4') then (
                                       <CardBrand>VISA</CardBrand>
                                    ) else if (substring(data($CARDNUMBER), 1,1) = '5') then (
                                       <CardBrand>MASTER CARD</CardBrand>
                                    ) else if (substring(data($CARDNUMBER), 1,1) = '3') then (
                                      <CardBrand>AMERICAN EXPRESS</CardBrand>
                                    ) else (
                                      <CardBrand>OTRA</CardBrand>
                                    ) 
                            }
                            {
                                for $CURRENCY1 in $mWSFICODEBITCARDCUSTOMERDetailType/CURRENCY1
                                return
                                   <CardCurrency>{ data($CURRENCY1) }</CardCurrency>
                            }
                            {
                                for $PRIMARYACCT in $mWSFICODEBITCARDCUSTOMERDetailType/PRIMARYACCT
                                return
                                   <CardAccountNumber>{ data($PRIMARYACCT) }</CardAccountNumber>
                            }
        </DebitCardCustomerRecords>
        }
    </ns0:getDebitCardsByCustomerResponse>
};

local:func($consultaMaestraTarjetaDebitoResponse1, $globalId, $status)