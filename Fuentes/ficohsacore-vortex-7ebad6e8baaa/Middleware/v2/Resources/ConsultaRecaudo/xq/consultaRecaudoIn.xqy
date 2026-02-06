xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo1" element="ns1:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallederecaudo" location="../../../../Business_Resources/recaudos/Resources/XMLSchema_-1599652964.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/consultaRecaudoIn/";

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

declare function xf:consultaRecaudoIn($requestHeader1 as element(ns2:RequestHeader),
    $consultaRecaudo1 as element(ns1:consultaRecaudo))
    as element(ns0:Consultadedetallederecaudo) {
        <ns0:Consultadedetallederecaudo>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentitacion/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <LATAMAGWSPENDINGBILLSType>
                <enquiryInputCollection>
                	<columnName>AGR.CONTRACT.ID</columnName>
                    <criteriaValue>{ data($consultaRecaudo1/CONTRACT_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>DEBTOR.CODE</columnName>
                    <criteriaValue>{ fn:replace(data($consultaRecaudo1/DEBTOR_CODE),"Ñ","#") }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>TXN.CCY</columnName>
                    <criteriaValue>{ data($consultaRecaudo1/CURRENCY) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                {
                	let $BILL_RETURN_TYPE := fn:string($consultaRecaudo1/BILL_RETURN_TYPE/text())
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
        </ns0:Consultadedetallederecaudo>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $consultaRecaudo1 as element(ns1:consultaRecaudo) external;

xf:consultaRecaudoIn($requestHeader1,
    $consultaRecaudo1)