xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns2:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadedetallederecaudo" location="../../../../Business_Resources/recaudos/Resources/XMLSchema_-1599652964.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaRecaudo/xq/consultaRecaudoIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns1 = "T24WebServicesImpl";

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
 
declare function xf:consultaRecaudoIn($requestHeader as element(ns0:RequestHeader),
    $consultaRecaudo as element(ns2:consultaRecaudo))
    as element(ns1:Consultadedetallederecaudo) {
        <ns1:Consultadedetallederecaudo>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <LATAMAGWSPENDINGBILLSType>
                <enquiryInputCollection>
                    <columnName>AGR.CONTRACT.ID</columnName>
                    <criteriaValue>{ data($consultaRecaudo/CONTRACT_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>DEBTOR.CODE</columnName>
                    <criteriaValue>{ fn:replace(data($consultaRecaudo/DEBTOR_CODE),"Ñ","#") }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>TXN.CCY</columnName>
                    <criteriaValue>{ data($consultaRecaudo/CURRENCY) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                {
                	let $BILL_RETURN_TYPE := fn:string($consultaRecaudo/BILL_RETURN_TYPE/text())
                	return 
	                	if( $BILL_RETURN_TYPE = "ONE" ) then (
			                <enquiryInputCollection>
			                    <columnName>CHANNEL.IND</columnName>
			                    <criteriaValue>ATM</criteriaValue>
			                    <operand>EQ</operand>
			                </enquiryInputCollection>
			        	) else if( $BILL_RETURN_TYPE = "ALL" ) then (
			                <enquiryInputCollection>
			                    <columnName>CHANNEL.IND</columnName>
			                    <criteriaValue>OTHER</criteriaValue>
			                    <operand>EQ</operand>
			                </enquiryInputCollection>
			        	) else ()
                }                                                
            </LATAMAGWSPENDINGBILLSType>
        </ns1:Consultadedetallederecaudo>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaRecaudo as element(ns2:consultaRecaudo) external;

xf:consultaRecaudoIn($requestHeader,
    $consultaRecaudo)