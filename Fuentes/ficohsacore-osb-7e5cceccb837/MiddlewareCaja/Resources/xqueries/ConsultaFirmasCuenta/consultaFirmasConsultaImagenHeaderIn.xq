xquery version "1.0" encoding "Cp1252";
(:: pragma  type="xs:anyType" ::)

declare namespace soapenv = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaFirmasCuenta/sdfdsdf/";

declare function xf:sdfdsdf($username as xs:string,
    $password as xs:string)
    as element(*) {
       <soapenv:Header>    
	        <ns0:AutenticacionRequestHeader>
	            <UserName>{ $username }</UserName>
	            <Password>{ $password }</Password>
	        </ns0:AutenticacionRequestHeader>
        </soapenv:Header>
        
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;

xf:sdfdsdf($username,
    $password)