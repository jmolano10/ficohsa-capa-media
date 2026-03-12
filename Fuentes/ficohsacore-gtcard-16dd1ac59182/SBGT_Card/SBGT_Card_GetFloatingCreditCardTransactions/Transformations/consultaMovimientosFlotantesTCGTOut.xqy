xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.procesa.com/fdcs";
(:: import schema at "../Schemas/XMLSchema_769155616.xsd" ::)
declare namespace ns0="https://www.ficohsa.com/regional/card";
(:: import schema at "../../SBGT_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)

declare variable $outstandingAuthorizationInquiryResponse as element() (:: schema-element(ns1:OutstandingAuthorizationInquiryResponse) ::) external;
declare variable $cardHolderName as xs:string external;
declare variable $lcyAmmount as xs:string external;
declare variable $usdAmmount as xs:string external;
declare variable $lcymovements as element()* external;
declare variable $usdmovements as element()* external;
declare variable $carNumberRequest as xs:string external;
declare variable $globalId as xs:string external;

declare function local:replace-first
  ( $arg as xs:string? ,
    $pattern as xs:string ,
    $replacement as xs:string )  as xs:string {

   replace($arg, concat('(^.*?)', $pattern),
             concat('$1',$replacement))
 } ;



declare function local:coreToRegional($outstandingAuthorizationInquiryResponse as element() (:: schema-element(ns1:OutstandingAuthorizationInquiryResponse) ::), 
                                      $cardHolderName as xs:string, 
                                      $lcyAmmount as xs:string, 
                                      $usdAmmount as xs:string, 
                                      $lcymovements as element()*, 
                                      $usdmovements as element()*, 
                                      $carNumberRequest as xs:string,
                                      $globalId as xs:string) 
                                      as element() (:: schema-element(ns0:getFloatingCreditCardTransactionsResponse) ::) {
    <ns0:getFloatingCreditCardTransactionsResponse>
    
        <StatusInfo>
            <Status>{'Success'}</Status>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
    
    
    <OwnerName>{ $cardHolderName }</OwnerName>
    <PrincipalCardNumber>{ $carNumberRequest }</PrincipalCardNumber>
    <TotalLcyAmount>{if ($lcyAmmount = '0') then '0.00' else fn-bea:format-number(number($lcyAmmount),"##0.00")}</TotalLcyAmount>
    <TotalUsdAmount>{if ($usdAmmount = '0') then '0.00' else fn-bea:format-number(number($usdAmmount),"##0.00")}</TotalUsdAmount>
    
        <CardsDetails>
            <CardNumber>{ 
                let $cardNumber :=  fn-bea:trim(fn:replace(fn:string(local:replace-first(data($lcymovements/OutstandingAuthArray/OutstandingAuthData[1]/OFXOAO-CARD-NBR), '0', '-')),"-", " "))
                return
                    if ($cardNumber  = '') then (
                        fn-bea:trim(fn:replace(fn:string(local:replace-first(data($usdmovements/OutstandingAuthArray/OutstandingAuthData[1]/OFXOAO-CARD-NBR), '0', '-')),"-", " "))        
                    )
                    else
                        $cardNumber     
            }</CardNumber>
            <LcyAmount>{if ($lcyAmmount = '0') then '0.00' else fn-bea:format-number(number($lcyAmmount),"##0.00")}</LcyAmount>
            <UsdAmount>{if ($usdAmmount = '0') then '0.00' else fn-bea:format-number(number($usdAmmount),"##0.00")}</UsdAmount>
            
                {
                    for $OutstandingAuthData in $usdmovements/OutstandingAuthArray/OutstandingAuthData
                    return
                        <FloatingMovements>
                            <MccCode>{ data($OutstandingAuthData/OFXOAO-MERCH-CAT-CD) }</MccCode>
                            <MccDescription>{ data($OutstandingAuthData/OFXOAO-CRD-ACCPT-NAME-LOC) }</MccDescription>
                            <Description>{ data($OutstandingAuthData/OFXOAO-TRANSACTION-DESC) }</Description>
                            <Date>{ data($OutstandingAuthData/OFXOAO-EFF-DATE) }</Date>
                            <Time>{ data($OutstandingAuthData/OFXOAO-TIME) }</Time>
                            <Amount>{ data($OutstandingAuthData/OFXOAO-AUTH-AMOUNT) }</Amount>
                            <Currency>GTQ</Currency>
                            <Fee>00</Fee>
                            <PaymentMethod>0000</PaymentMethod>
                        </FloatingMovements>
                }
                {
                    for $OutstandingAuthData in $lcymovements/OutstandingAuthArray/OutstandingAuthData
                    return
                        <FloatingMovements>
                            <MccCode>{ data($OutstandingAuthData/OFXOAO-MERCH-CAT-CD) }</MccCode>
                            <MccDescription>{ data($OutstandingAuthData/OFXOAO-CRD-ACCPT-NAME-LOC) }</MccDescription>
                            <Description>{ data($OutstandingAuthData/OFXOAO-TRANSACTION-DESC) }</Description>
                            <Date>{ data($OutstandingAuthData/OFXOAO-EFF-DATE) }</Date>
                            <Time>{ data($OutstandingAuthData/OFXOAO-TIME) }</Time>
                            <Amount>{ data($OutstandingAuthData/OFXOAO-AUTH-AMOUNT) }</Amount>
                            <Currency>GTQ</Currency>
                            <Fee>00</Fee>
                            <PaymentMethod>0000</PaymentMethod>
                        </FloatingMovements>
                }
            
        </CardsDetails>
    
</ns0:getFloatingCreditCardTransactionsResponse>

};

local:coreToRegional($outstandingAuthorizationInquiryResponse, $cardHolderName, $lcyAmmount, $usdAmmount, $lcymovements, $usdmovements, $carNumberRequest,$globalId)