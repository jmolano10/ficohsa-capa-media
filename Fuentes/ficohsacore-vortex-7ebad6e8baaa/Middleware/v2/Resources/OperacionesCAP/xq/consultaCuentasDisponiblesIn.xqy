xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaCuentasDisponiblesRequest" element="ns1:consultaCuentasDisponiblesRequest" location="../xsd/operacionesCAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultacuentasdeorigendisponib" location="../../../BusinessServices/T24/svcAhorroProgramado/xsd/svcAhorroProgramado.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/consultaCuentasDisponiblesIn/";

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

declare function xf:consultaCuentasDisponiblesIn($requestHeader as element(ns2:RequestHeader),
    $consultaCuentasDisponiblesRequest as element(ns1:consultaCuentasDisponiblesRequest))
    as element(ns0:Consultacuentasdeorigendisponib) {
        <ns0:Consultacuentasdeorigendisponib>
            <WebRequestCommon>
                <userName>
                		{
                			fn-bea:fail-over(getUsername(data($requestHeader/Authentication/UserName)),
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
            <WSFICOHNACCTCRRYType>
                <enquiryInputCollection>
                    <columnName>CUSTOMER</columnName>
                    <criteriaValue>{ data($consultaCuentasDisponiblesRequest/ID_CLIENTE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>CURRENCY</columnName>
                    <criteriaValue>{ data($consultaCuentasDisponiblesRequest/MONEDA) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOHNACCTCRRYType>
        </ns0:Consultacuentasdeorigendisponib>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $consultaCuentasDisponiblesRequest as element(ns1:consultaCuentasDisponiblesRequest) external;

xf:consultaCuentasDisponiblesIn($requestHeader,
    $consultaCuentasDisponiblesRequest)