xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/ConsultasCuentaT24/v1.0/ConsultaDetalleCuentaBS.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getAccountDetails";
(:: import schema at "../../../../../../MWBanking/Accounts/RequestorServices/XSD/getAccountDetails.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $t24Response as element() (:: schema-element(ns1:ConsultadetallecuentaResponse) ::) external;
declare variable $uuid as xs:string external;
declare variable $accountNumber as xs:string external;

declare function xq:Tx_AccountDetails_To_FinalResponse($t24Response as element() (:: schema-element(ns1:ConsultadetallecuentaResponse) ::), 
                                                       $uuid as xs:string, 
                                                       $accountNumber as xs:string) 
                                                       as element() (:: schema-element(ns2:getAccountDetailsResponse) ::) {
    <ns2:getAccountDetailsResponse>
        <ns2:StatusInfo>
            {
                if (fn:data($t24Response/ACCOUNTLISTDYNWSType/ZERORECORDS)!='')
                then <com:Status>NO RECORDS</com:Status>
                else
                if ($t24Response/Status/successIndicator)
                then <com:Status>{fn:data($t24Response/Status/successIndicator)}</com:Status>
                else()
            }
            {
                if ($t24Response/Status/transactionId)
                then <com:TransactionId>{fn:data($t24Response/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:AccountDetails>
            <ns2:AccountNumber>{fn:data($accountNumber)}</ns2:AccountNumber>
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/CUSTOMERNUMBER)
                then <ns2:CustomerId>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/CUSTOMERNUMBER)}</ns2:CustomerId>
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/SHORTTITLE)
                then <ns2:AccountName>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/SHORTTITLE)}</ns2:AccountName>
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/CATEGORY)
                then <ns2:Category>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/CATEGORY)}</ns2:Category>
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/CURRENCY)
                then <ns2:Currency>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/CURRENCY)}</ns2:Currency>
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/LIMITREF)
                then <ns2:LimitRef>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/LIMITREF)}</ns2:LimitRef>
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/POSTINGRESTRICT)
                then <ns2:Restrictions>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/POSTINGRESTRICT)}</ns2:Restrictions>
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/ACCOUNTOFFICER)
                then <ns2:AltAccount>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/ALTACCTID)}</ns2:AltAccount>
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/OPENINGDATE)
                then <ns2:OpeningDate>{fn:concat(fn:substring(fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/OPENINGDATE),0,5),'-',fn:substring(fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/OPENINGDATE),5,2),'-',fn:substring(fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/OPENINGDATE),7,2))
                }</ns2:OpeningDate>
                
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/OPERATIONTYPE)
                then <ns2:OperationType>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/OPERATIONTYPE)}</ns2:OperationType>
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/ACCOUNTOFFICER)
                then <ns2:AccountOfficer>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/ACCOUNTOFFICER)}</ns2:AccountOfficer>
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/BRANCHCODE)
                then <ns2:BranchCode>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/BRANCHCODE)}</ns2:BranchCode>
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/LEGALID)
                then <ns2:LegalId>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/LEGALID)}</ns2:LegalId>
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/REQUIREDSIGNATURES)
                then <ns2:RequiredSignatures>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/REQUIREDSIGNATURES)}</ns2:RequiredSignatures>
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/SIGNATUREDESC)
                then <ns2:SignaturesDesc>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/SIGNATUREDESC)}</ns2:SignaturesDesc>
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/INACTIVEMARKER)
                then <ns2:InactiveMarker>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/INACTIVEMARKER)}</ns2:InactiveMarker>
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/LRPURPOSE)
                then <ns2:Purpose>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/LRPURPOSE)}</ns2:Purpose>
                else ()
            }
            {
                if ($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/LRMONTXVOL)
                then <ns2:MonthlyTxnVolume>{fn:data($t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType[1]/LRMONTXVOL)}</ns2:MonthlyTxnVolume>
                else ()
            }
            <ns2:ThirdPartyRepresentative>NO</ns2:ThirdPartyRepresentative>
            {
               for $benfeficiaries in $t24Response/ACCOUNTLISTDYNWSType/gACCOUNTLISTDYNWSDetailType/mACCOUNTLISTDYNWSDetailType
               return
              <ns2:BeneficiaryDetails>        
                  {
                      if ($benfeficiaries/LRBENNAME)
                      then <ns2:Name>{fn:data($benfeficiaries/LRBENNAME)}</ns2:Name>
                      else ()
                  }
                  {
                      if ($benfeficiaries/LRBENRELN)
                      then <ns2:Relationship>{fn:data($benfeficiaries/LRBENRELN)}</ns2:Relationship>
                      else ()
                  }
                  {
                      if ($benfeficiaries/LRTINACT)
                      then <ns2:DocumentType>{fn:data($benfeficiaries/LRTINACT)}</ns2:DocumentType>
                      else ()
                  }
                  {
                      if ($benfeficiaries/LRNUMACT)
                      then <ns2:LegalId>{fn:data($benfeficiaries/LRNUMACT)}</ns2:LegalId>
                      else ()
                  }
                  {
                      if ($benfeficiaries/LRBENPRG)
                      then <ns2:Percentege>{fn:data($benfeficiaries/LRBENPRG)}</ns2:Percentege>
                      else ()
                  }</ns2:BeneficiaryDetails>
            }
        </ns2:AccountDetails>
    </ns2:getAccountDetailsResponse>
};

xq:Tx_AccountDetails_To_FinalResponse($t24Response, $uuid, $accountNumber)