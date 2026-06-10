<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ConsultadecuentaACTIVAPOSTREST" location="../../../BusinessServices/T24/RetiroSinTD/xsd/operacionesRetiroSinTDTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroCuponTD/xq/consultaCuentaT24In/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:consultaCuentaT24In($requestHeader as element(ns0:RequestHeader),
    $accountNumber as xs:string,
    $codDespignoracion as xs:string,
    $terminalID as xs:string)
    as element(ns1:ConsultadecuentaACTIVAPOSTREST) {
        <ns1:ConsultadecuentaACTIVAPOSTREST>
            <WebRequestCommon>
                <userName>{fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName)) }</userName>
                <password>{fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))}</password>
            </WebRequestCommon>
            <FICONOFILEPOSTRESTINACType>
                <enquiryInputCollection>
                    <columnName>ACCOUNT.ID</columnName>
                    <criteriaValue>{ data($accountNumber) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>AC.LOCKED.ID</columnName>
                    <criteriaValue>{ data($codDespignoracion) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>TERMINAL.ID</columnName>
                    <criteriaValue>{ data($terminalID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICONOFILEPOSTRESTINACType>
        </ns1:ConsultadecuentaACTIVAPOSTREST>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $accountNumber as xs:string external;
declare variable $codDespignoracion as xs:string external;
declare variable $terminalID as xs:string external;

xf:consultaCuentaT24In($requestHeader,
    $accountNumber,
    $codDespignoracion,
    $terminalID)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/T24/RetiroSinTD/xsd/operacionesRetiroSinTDTypes.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/T24/RetiroSinTD/xsd/operacionesRetiroSinTDTypes"/>
    </con:dependency>
</con:xqueryEntry>