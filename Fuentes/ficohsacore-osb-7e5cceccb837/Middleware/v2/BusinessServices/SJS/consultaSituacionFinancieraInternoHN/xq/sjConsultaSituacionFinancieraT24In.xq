(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$group" type="ns1:GROUP" location="../../../../Resources/ConsultaSituacionFinanciera/xsd/sjConsultaSituacionFinancieraInterno.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaSituacionFinanciera" location="../../../T24/consultaSituacionFinanciera/xsd/XMLSchema_-1839398308.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSituacionFinancieraInterno";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoHN/xq/sjConsultaSituacionFinancieraT24In(/";

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
 
declare function xf:sjConsultaSituacionFinancieraT24In($requestHeader as element(ns2:RequestHeader),
	$group as element())
    as element(ns0:ConsultaSituacionFinanciera) {
        <ns0:ConsultaSituacionFinanciera>
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
            <FICOECUSTACTPASPRODSWSType>
	           	<enquiryInputCollection>
	               <columnName>CUSTOMER.ID</columnName>
	               <criteriaValue> { fn:string-join($group/CUSTOMERS/CUSTOMER/ID, '||') } </criteriaValue>
	               <operand>EQ</operand>
	            </enquiryInputCollection>
	            <enquiryInputCollection>
	               <columnName>PRODUCT.ID</columnName>
	               <criteriaValue>{ fn:string-join($group/PRODUCTS/PRODUCT/ID, '||') }</criteriaValue>
	               <operand>EQ</operand>
            	</enquiryInputCollection>
            </FICOECUSTACTPASPRODSWSType>
        </ns0:ConsultaSituacionFinanciera>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $group as element() external;

xf:sjConsultaSituacionFinancieraT24In($requestHeader,
	$group)
