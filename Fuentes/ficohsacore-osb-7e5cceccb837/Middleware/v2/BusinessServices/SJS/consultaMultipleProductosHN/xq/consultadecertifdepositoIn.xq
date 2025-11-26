(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductosHN" element="ns1:sjConsultaMultipleProductosHN" location="../xsd/sjConsultaMultipleProductosHN.xsd" ::)
(:: pragma  parameter="$productosxTipo" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:Consultadecertifdeposito" location="../../../../../Business_Resources/consultaCertificadoDeposito/Resources/XMLSchema_1178015080.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosHN";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/consultadecertifdepositoIn/";

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

declare function xf:consultadecertifdepositoIn($sjConsultaMultipleProductosHN as element(ns1:sjConsultaMultipleProductosHN),
    $productosxTipo as element(*))
    as element(ns0:Consultadecertifdeposito) {
        <ns0:Consultadecertifdeposito>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over(getUsername(data($sjConsultaMultipleProductosHN/ns1:USERNAME)), 
												data($sjConsultaMultipleProductosHN/ns1:USERNAME)) }</userName>
                <password>{fn-bea:fail-over( getPassword(data($sjConsultaMultipleProductosHN/ns1:USERNAME)),
                								data($sjConsultaMultipleProductosHN/ns1:PASSWORD))}</password>
            </WebRequestCommon>
            <WSAZACCOUNTDEPType>
            {
	            for $i in 1 to count($productosxTipo/PRODUCTS/ID)
	            return
	                <enquiryInputCollection>
	                    <columnName>@ID</columnName>
	                    <criteriaValue>{ data($productosxTipo/PRODUCTS/ID[$i]) }</criteriaValue>
	                    <operand>EQ</operand>
	                </enquiryInputCollection>
            }
            </WSAZACCOUNTDEPType>
        </ns0:Consultadecertifdeposito>
};

declare variable $sjConsultaMultipleProductosHN as element(ns1:sjConsultaMultipleProductosHN) external;
declare variable $productosxTipo as element(*) external;

xf:consultadecertifdepositoIn($sjConsultaMultipleProductosHN,
    $productosxTipo)