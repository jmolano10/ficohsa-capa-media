xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/CreateAccount/CreateAccount_BS.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/accountsTypes";
(:: import schema at "../../../../../../MWBanking/Accounts/RequestorServices/XSD/accountsTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/createAccountHNOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $aperturaCuentasClienteResponse as element() (:: schema-element(ns2:AperturaCuentasClienteResponse) ::) external;

declare function ns1:createAccountHNOut($uuid as xs:string, 
                                        $sourceBank as xs:string, 
                                        $aperturaCuentasClienteResponse as element() (:: schema-element(ns2:AperturaCuentasClienteResponse) ::)) 
                                        as element() (:: schema-element(ns3:createAccountResponse) ::) {
    <ns3:createAccountResponse>
        <ns3:StatusInfo>
            {
                if ($aperturaCuentasClienteResponse/Status/successIndicator)
                then <com:Status>{fn:data($aperturaCuentasClienteResponse/Status/successIndicator)}</com:Status>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        {
            if ($aperturaCuentasClienteResponse/FICOBULKAPPRCLNTType/FIELDS51)
            then <ns3:AccountNumber>{fn:data($aperturaCuentasClienteResponse/FICOBULKAPPRCLNTType/FIELDS51)}</ns3:AccountNumber>
            else ()
        }
    </ns3:createAccountResponse>
};

ns1:createAccountHNOut($uuid, $sourceBank, $aperturaCuentasClienteResponse)
