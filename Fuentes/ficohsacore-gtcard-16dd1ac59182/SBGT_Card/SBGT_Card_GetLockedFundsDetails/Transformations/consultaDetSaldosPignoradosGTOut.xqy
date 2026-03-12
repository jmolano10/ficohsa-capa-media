xquery version "1.0" encoding "utf-8";
  
  (:: OracleAnnotationVersion "1.0" ::)
  
  declare namespace ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleSaldosPignorados";
  (:: import schema at "../Schemas/consultaDetalleSaldosPignorados_sp.xsd" ::)
  declare namespace card="https://www.ficohsa.com/regional/card";
  (:: import schema at "../../SBGT_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)
  
  declare variable $OutputParameters as element() (:: schema-element(ns0:OutputParameters) ::) external;
declare variable $globalId as xs:string external;
declare variable $status as xs:string external;
  
declare function local:format-date($inputDate as xs:string) as xs:string {
  let $year := substring($inputDate, 1, 4)
  let $month := substring($inputDate, 5, 2)
  let $day := substring($inputDate, 7, 2)
  return concat($year, '-', $month, '-', $day)
};
  
  declare function local:func($OutputParameters as element() (:: schema-element(ns0:OutputParameters) ::), $globalId as xs:string, $status as xs:string) as element() (:: schema-element(card:getLockedFundsDetailsReponse) ::) {
      <card:getLockedFundsDetailsReponse>
        <StatusInfo>
            <Status>{fn:data($status)}</Status>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        
        <AccountName>{ data($OutputParameters/ns0:ACCOUNT_NAME) }</AccountName>
        <TotalLockedAmount>{ data($OutputParameters/ns0:TOTAL_LOCKED_AMOUNT) }</TotalLockedAmount>
              {
                  let $startDate := $OutputParameters/ns0:START_DATE/ns0:START_DATE_ITEM
                  let $liftingDate := $OutputParameters/ns0:LIFTING_DATE/ns0:START_DATE_ITEM
                  let $description := $OutputParameters/ns0:DESCRIPTION/ns0:DESCRIPTION_ITEM
                  let $amount := $OutputParameters/ns0:AMOUNT/ns0:START_DATE_ITEM
                  
                  for $i in (1 to count($startDate))
                    return
                      <GetLockedFundsDetails>
                       <StartDate>{ if($startDate[$i]/@xsi:nil="true")then(
                      ()
                      )else(
                      local:format-date(data($startDate[$i]))
                      )}</StartDate>
                      <LiftingDate>{ if($liftingDate[$i]/@xsi:nil="true")then(
                      ()
                      )else(
                      local:format-date(data($liftingDate[$i]))
                      )}</LiftingDate>
                      <Description>{ data($description[$i]) }</Description>
                      <Amount>{ data($amount[$i]) }</Amount>
                      </GetLockedFundsDetails>
              }
      </card:getLockedFundsDetailsReponse>
  };
  
  local:func($OutputParameters, $globalId, $status)