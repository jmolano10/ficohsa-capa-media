xquery version "1.0" encoding "utf-8";
  
  (:: OracleAnnotationVersion "1.0" ::)
  
  declare namespace ns0 = "T24WebServicesImpl";
  (:: import schema at "../Schemas/GetLockedFundsDetails/XMLSchema_-955040778.xsd" ::)
  declare namespace card = "https://www.ficohsa.com/regional/card";
  (:: import schema at "../../SBHN_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)
  
  declare variable $consultadebloqueosporTDResponse as element() (:: schema-element(ns0:getLockedFundsDetailsResponse) ::) external;
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
  
  declare function local:func($consultadebloqueosporTDResponse as element() (:: schema-element(ns0:getLockedFundsDetailsResponse) ::), $globalId as xs:string, $status as xs:string) as element() (:: schema-element(card:getLockedFundsDetailsReponse) ::) {
    <card:getLockedFundsDetailsReponse>
         <StatusInfo>
          <Status>{fn:data($status)}</Status>
          <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
          <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
          <GlobalId>{fn:data($globalId)}</GlobalId>
      </StatusInfo>
            <AccountName>{ data($consultadebloqueosporTDResponse/WSFICOECUSTPOSVISATXNSType[1]/ACCOUNTNAME) }</AccountName>
            <TotalLockedAmount>{ data($consultadebloqueosporTDResponse/WSFICOECUSTPOSVISATXNSType[1]/TOTAMTBLOCKED) }</TotalLockedAmount>
                     {
                       for $mWSFICOECUSTPOSVISATXNSDetailType in $consultadebloqueosporTDResponse/WSFICOECUSTPOSVISATXNSType[1]/gWSFICOECUSTPOSVISATXNSDetailType/mWSFICOECUSTPOSVISATXNSDetailType
                          return
                              <GetLockedFundsDetails>
                                  {
                                     for $startDate in $mWSFICOECUSTPOSVISATXNSDetailType/TXNDATE
                                      return
                                      <StartDate>{ if($startDate/text()='')then(
                                      ()
                                      )else(
                                      local:format-date(data($startDate)))}</StartDate>                                      
                                  }
                                  {
                                     for $liftingDate in $mWSFICOECUSTPOSVISATXNSDetailType/EXPIRYDATE
                                     return
                                      <LiftingDate>{ local:format-date(data($liftingDate))}</LiftingDate>
                                    
                                  }
                                  {
                                     for $description in $mWSFICOECUSTPOSVISATXNSDetailType/DESCRIPTION
                                      return
                                      <Description>{ data($description) }</Description>
                                  }
                                  {
                                     for $amount in $mWSFICOECUSTPOSVISATXNSDetailType/AMTBLOCKED
                                      return
                                      <Amount>{ data($amount) }</Amount>
                                  }
                                  {
                                     for $lockId in $mWSFICOECUSTPOSVISATXNSDetailType/TRANSACTIONREF
                                      return
                                      <LockId>{ data($lockId) }</LockId>
                                  }
                            </GetLockedFundsDetails>
}
        </card:getLockedFundsDetailsReponse>
};
  
  local:func($consultadebloqueosporTDResponse, $globalId, $status)