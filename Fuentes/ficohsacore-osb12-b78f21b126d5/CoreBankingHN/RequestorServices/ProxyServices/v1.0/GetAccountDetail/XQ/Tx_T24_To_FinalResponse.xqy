xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/ConsultasCuentaT24/v1.0/ConsultasCuentaBS.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getAccountDetails";
(:: import schema at "../../../../../../MWBanking/Accounts/RequestorServices/XSD/getAccountDetails.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace cmm = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $t24Response as element() (:: schema-element(ns1:ConsultadedetallesdelacuentaResponse) ::) external;
declare variable $uuid as xs:string external;
declare variable $accountNumber as xs:string external;

declare function xq:Tx_T24_To_FinalResponse($t24Response as element() (:: schema-element(ns1:ConsultadedetallesdelacuentaResponse) ::), 
                                            $uuid as xs:string, 
                                            $accountNumber as xs:string) 
                                            as element() (:: schema-element(ns2:getAccountDetailsResponse) ::) {
    <ns2:getAccountDetailsResponse>
        <ns2:StatusInfo>
            {
                if (fn:data($t24Response/WSACCOUNTLISTType/ZERORECORDS)!='')
                then <cmm:Status>NO RECORDS</cmm:Status>
                else
                if ($t24Response/Status/successIndicator)
                then <cmm:Status>{fn:data($t24Response/Status/successIndicator)}</cmm:Status>
                else()
            }
            {
                if ($t24Response/Status/transactionId)
                then <cmm:TransactionId>{fn:data($t24Response/Status/transactionId)}</cmm:TransactionId>
                else ()
            }
            <cmm:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</cmm:ValueDate>
            <cmm:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</cmm:DateTime>
            <cmm:GlobalId>{fn:data($uuid)}</cmm:GlobalId>
        </ns2:StatusInfo>
        <ns2:AccountDetails>
            <ns2:AccountNumber>{fn:data($accountNumber)}</ns2:AccountNumber>
            {
                if ($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CUSTOMERNUMBER)
                then <ns2:CustomerId>{fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CUSTOMERNUMBER)}</ns2:CustomerId>
                else ()
            }
            {
                if ($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/SHORTTITLE)
                then <ns2:AccountName>{fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/SHORTTITLE)}</ns2:AccountName>
                else ()
            }
            {
                if ($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CATEGORY)
                then <ns2:Category>{fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CATEGORY)}</ns2:Category>
                else ()
            }
            {
                if ($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CURRENCY)
                then <ns2:Currency>{fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CURRENCY)}</ns2:Currency>
                else ()
            }
            {
                if ($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/LIMITREF)
                then <ns2:LimitRef>{fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/LIMITREF)}</ns2:LimitRef>
                else ()
            }
            {
                if ($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/POSTINGRESTRICT)
                then <ns2:Restrictions>{fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/POSTINGRESTRICT)}</ns2:Restrictions>
                else ()
            }
            {
                if ($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/ALTACCTID)
                then <ns2:AltAccount>{fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/ALTACCTID)}</ns2:AltAccount>
                else ()
            }
            {
                if ($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/OPENINGDATE)
                then <ns2:OpeningDate>{
                fn:concat(fn:substring(fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/OPENINGDATE),0,5),'-',fn:substring(fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/OPENINGDATE),5,2),'-',fn:substring(fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/OPENINGDATE),7,2))
                }</ns2:OpeningDate>
                else ()
            }
            {
                if ($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/OPERATIONTYPE)
                then <ns2:OperationType>{fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/OPERATIONTYPE)}</ns2:OperationType>
                else ()
            }
            {
                if ($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/ACCOUNTOFFICER)
                then <ns2:AccountOfficer>{fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/ACCOUNTOFFICER)}</ns2:AccountOfficer>
                else ()
            }
            {
                if ($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/BRANCHCODE)
                then <ns2:BranchCode>{fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/BRANCHCODE)}</ns2:BranchCode>
                else ()
            }
            {
                if ($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/LEGALID)
                then <ns2:LegalId>{fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/LEGALID)}</ns2:LegalId>
                else ()
            }
            {
                if ($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/SIGNATUREDESC)
                then <ns2:RequiredSignatures>{fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/REQUIREDSIGNATURES)}</ns2:RequiredSignatures>
                else ()
            }
            {
                if ($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/SIGNATUREDESC)
                then <ns2:SignaturesDesc>{fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/SIGNATUREDESC)}</ns2:SignaturesDesc>
                else ()
            }
            {
                if ($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/INACTIVEMARKER)
                then <ns2:InactiveMarker>{fn:data($t24Response/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/INACTIVEMARKER)}</ns2:InactiveMarker>
                else ()
            }
            <ns2:Purpose>PLANILLA</ns2:Purpose>
            <ns2:MonthlyTxnVolume>1000</ns2:MonthlyTxnVolume>
            <ns2:ThirdPartyRepresentative>NO</ns2:ThirdPartyRepresentative>
            <ns2:BeneficiaryDetails>
                <ns2:Name>Juan Alberto Maradiaga</ns2:Name>
                <ns2:Relationship>Hermano</ns2:Relationship>
                <ns2:DocumentType>Cedula</ns2:DocumentType>
                <ns2:LegalId>0801198022222</ns2:LegalId>
                <ns2:Percentege>100</ns2:Percentege>
            </ns2:BeneficiaryDetails>
        </ns2:AccountDetails>
    </ns2:getAccountDetailsResponse>
};

xq:Tx_T24_To_FinalResponse($t24Response, $uuid, $accountNumber)