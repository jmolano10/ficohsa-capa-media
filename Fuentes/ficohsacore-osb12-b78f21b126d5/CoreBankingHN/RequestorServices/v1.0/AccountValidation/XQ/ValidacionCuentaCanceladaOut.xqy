xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/ConsultasCuentaT24/v1.0/ConsultasCuentaBS.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/accountValidation";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/accountValidationTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $ConsultadeCuentasCanceladasRSP as element() (:: schema-element(ns1:ConsultadecuentascanceladasResponse) ::) external;
declare variable $uuid as xs:string external;
declare variable $RSPDetallesCuenta as element() (:: schema-element(ns1:ConsultadedetallesdelacuentaResponse) ::) external;
declare variable $accountFound as xs:string external;

declare function local:func($uuid as xs:string, $ConsultadeCuentasCanceladasRSP as element() (:: schema-element(ns1:ConsultadecuentascanceladasResponse) ::), 
                            $accountFound as xs:string) 
                            as element() (:: schema-element(ns2:accountValidationResponse) ::) {
    <ns2:accountValidationResponse>
    <ns2:StatusInfo>
            {
                if ($ConsultadeCuentasCanceladasRSP/Status/successIndicator)
                then <com:Status>{fn:data($ConsultadeCuentasCanceladasRSP/Status/successIndicator)}</com:Status>
                else ()
            }
            {
                if ($ConsultadeCuentasCanceladasRSP/Status/transactionId)
                then <com:TransactionId>{fn:data($ConsultadeCuentasCanceladasRSP/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:AccountNumber>{fn:data($accountFound)}</ns2:AccountNumber>
        {
            for $ACCOUNTNAME in $ConsultadeCuentasCanceladasRSP/WSACCOUNTCLOSEDType[1]/gWSACCOUNTCLOSEDDetailType/mWSACCOUNTCLOSEDDetailType[1]/ACCOUNTNAME
              return
              <ns2:AccountName>{fn:data($ACCOUNTNAME)}</ns2:AccountName>
        }
        <ns2:AccountStatus>CANCELLED</ns2:AccountStatus>
    </ns2:accountValidationResponse>
};

local:func($uuid, $ConsultadeCuentasCanceladasRSP, $accountFound)