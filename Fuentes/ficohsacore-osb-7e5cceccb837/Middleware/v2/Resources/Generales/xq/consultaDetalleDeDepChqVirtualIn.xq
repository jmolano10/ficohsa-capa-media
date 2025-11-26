xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaDetalleDeDepChqVirtual" location="../../../../Business_Resources/compensacion/resources/XMLSchema_1569843523.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/xq/consultaDetalleDeDepChqVirtualIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

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

declare function xf:consultaDetalleDeDepChqVirtualIn($requestHeader as element(ns0:RequestHeader),
    $id as xs:string)
    as element(ns1:ConsultaDetalleDeDepChqVirtual) {
        <ns1:ConsultaDetalleDeDepChqVirtual>
        	<WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
				</password>
            </WebRequestCommon>
            <CHQVIRNOTIFICAWSType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ $id }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </CHQVIRNOTIFICAWSType>
        </ns1:ConsultaDetalleDeDepChqVirtual>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $id as xs:string external;

xf:consultaDetalleDeDepChqVirtualIn($requestHeader,
    $id)
