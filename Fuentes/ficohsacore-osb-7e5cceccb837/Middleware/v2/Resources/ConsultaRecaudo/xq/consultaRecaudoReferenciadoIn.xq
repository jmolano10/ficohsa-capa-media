(:: pragma bea:global-element-parameter parameter="$requestHeaderIN" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoIN" element="ns1:consultaRecaudo" location="../xsd/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CalculoCobranzasReferenciadas" location="../../../../Business_Resources/recaudos/Resources/XMLSchema_-1599652964.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/consultaRecaudoReferenciadoIn/";

     (: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };


declare function xf:consultaRecaudoReferenciadoIn($requestHeaderIN as element(ns2:RequestHeader),
    $consultaRecaudoIN as element(ns1:consultaRecaudo))
    as element(ns0:CalculoCobranzasReferenciadas) {
           
        <ns0:CalculoCobranzasReferenciadas>
        <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeaderIN/Authentication/UserName)), 
												data($requestHeaderIN/Authentitacion/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeaderIN/Authentication/UserName)),
                								data($requestHeaderIN/Authentication/Password)) }</password>
            </WebRequestCommon>
            <NOFILELATAMCALCREFDUEWSType>
                <enquiryInputCollection>
                    <columnName>CONTRACT.ID</columnName>
                    <criteriaValue>{ data($consultaRecaudoIN/CONTRACT_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                 <enquiryInputCollection>
                    <columnName>DUE.DATE</columnName>
                    <criteriaValue>{ data($consultaRecaudoIN/BILL_DATE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                 <enquiryInputCollection>
                    <columnName>AMOUNT</columnName>
                    <criteriaValue>{ data($consultaRecaudoIN/BILL_AMOUNT) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                 <enquiryInputCollection>
                    <columnName>CURRENCY</columnName>
                    <criteriaValue>{ data($consultaRecaudoIN/CURRENCY) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </NOFILELATAMCALCREFDUEWSType>
        </ns0:CalculoCobranzasReferenciadas>
};

declare variable $requestHeaderIN as element(ns2:RequestHeader) external;
declare variable $consultaRecaudoIN as element(ns1:consultaRecaudo) external;

xf:consultaRecaudoReferenciadoIn($requestHeaderIN,
    $consultaRecaudoIN)
