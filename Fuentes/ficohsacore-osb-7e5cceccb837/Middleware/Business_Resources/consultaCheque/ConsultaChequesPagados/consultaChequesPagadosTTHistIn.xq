(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaChequesPagados" element="ns1:consultaChequesPagados" location="consultaChequesPagadosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaChequesPagadosTTHIS" location="../Resources/XMLSchema_516353548.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesPagadosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/ConsultaChequesPagados/consultaChequesPagadosTTHistIn/";

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

declare function xf:consultaChequesPagadosTTHistIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaChequesPagados as element(ns1:consultaChequesPagados))
    as element(ns0:ConsultaChequesPagadosTTHIS) {
        <ns0:ConsultaChequesPagadosTTHIS>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSTTCHEQUESPRESENTEDHISType>
                <enquiryInputCollection>
                    <columnName>VALUE.DATE.2</columnName>
                    <criteriaValue>{ data($consultaChequesPagados/TRANSACTION_DATE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                {
                	if (fn:string($consultaChequesPagados/BRANCH_CODE/text()) != "") then (
		                <enquiryInputCollection>
		                    <columnName>LR.AGENCY.CODE</columnName>
		                    <criteriaValue>{ data($consultaChequesPagados/BRANCH_CODE) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
                	) else ()
                }
            </WSTTCHEQUESPRESENTEDHISType>
        </ns0:ConsultaChequesPagadosTTHIS>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaChequesPagados as element(ns1:consultaChequesPagados) external;

xf:consultaChequesPagadosTTHistIn($autenticacionRequestHeader,
    $consultaChequesPagados)