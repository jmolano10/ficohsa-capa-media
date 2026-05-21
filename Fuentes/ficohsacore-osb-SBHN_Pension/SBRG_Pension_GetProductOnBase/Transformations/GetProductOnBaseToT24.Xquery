<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../Schemas/XMLSchema_1144838292.xsd" ::)

declare variable $userName as xs:string external;
declare variable $customerId as xs:string external;

(: Función encargada de realizar el mapeo de usuario:)
declare function xq:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("SB_Security/Common/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function xq:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("SB_Security/Common/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function local:func($userName as xs:string, 
                            $customerId as xs:string) 
                            as element() (:: schema-element(ns1:Consultadecliente) ::) {
    <ns1:Consultadecliente>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername($userName), $userName) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword($userName), $userName) }</password>
        </WebRequestCommon>
        <WSCUSTOMERType>
            <enquiryInputCollection>
                <columnName>@ID</columnName>
                <criteriaValue>{ $customerId }</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
        </WSCUSTOMERType>
    </ns1:Consultadecliente>
};

local:func($userName, $customerId)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/XMLSchema_1144838292.xsd">
            <con:schema ref="SBRG_Pension_GetProductOnBase/Schemas/XMLSchema_1144838292"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>