xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../../CoreBankingHN/ProviderServices/XSD/GetLoanTransaction/XMLSchema_-1304808041.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $userName as xs:string external;
declare variable $passWord as xs:string external;
declare variable $queryParam as xs:string external;
declare variable $paramType as xs:string external;


(: Función encargada de realizar el mapeo de usuario:)
declare function xq:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function xq:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function local:func($userName as xs:string, 
                            $passWord as xs:string, 
                            $queryParam as xs:string, 
                            $paramType as xs:string) 
                            as element() (:: schema-element(ns1:ConsultaDesembolsoPrestamo) ::) {
    <ns1:ConsultaDesembolsoPrestamo>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($userName)),data($passWord)) }</password>
        </WebRequestCommon>
        <FICODESPRESDYNType>
            <enquiryInputCollection>
                {
                    if( $paramType = 'LOAN') then (
                        <columnName>ID.PRESTAMO</columnName>     
                    )else (   
                        <columnName>@ID</columnName>    
                    )
                }         
                <criteriaValue>{ $queryParam }</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
        </FICODESPRESDYNType>
    </ns1:ConsultaDesembolsoPrestamo>
};

local:func($userName, $passWord, $queryParam, $paramType)