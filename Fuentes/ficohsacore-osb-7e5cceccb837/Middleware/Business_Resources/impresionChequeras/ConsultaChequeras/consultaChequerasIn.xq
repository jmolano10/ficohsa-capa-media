(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaChequeras" element="ns1:consultaChequeras" location="consultaChequerasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadechequerasporimprimir" location="../Resources/XMLSchema_1756805255.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaChequerasTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/impresionChequeras/ConsultaChequeras/consultaChequerasIn/";

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


declare function xf:consultaChequerasIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaChequeras as element(ns1:consultaChequeras))
    as element(ns0:Consultadechequerasporimprimir) {
        <ns0:Consultadechequerasporimprimir>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>        
            <WSCHECKBOOKREQUESTENQType>
                {
                	let $ACCOUNT_NUMBER := $consultaChequeras/ACCOUNT_NUMBER
                    return
                    	if ( data($ACCOUNT_NUMBER) != "" ) then (
                        	<enquiryInputCollection>
                            	<columnName>ACCOUNT.NUMBER</columnName>
                            	<criteriaValue>{ data($ACCOUNT_NUMBER) }</criteriaValue>
                            	<operand>EQ</operand>
                        	</enquiryInputCollection>
                        ) else ()
                }            
                {
                	let $CHEQUEBOOK_STATUS := $consultaChequeras/CHEQUEBOOK_STATUS
                    return
                    	if ( data($CHEQUEBOOK_STATUS) != "" ) then (
                        	<enquiryInputCollection>
                            	<columnName>STATUS</columnName>
                            	<criteriaValue>{ data($CHEQUEBOOK_STATUS) }</criteriaValue>
                            	<operand>EQ</operand>
                        	</enquiryInputCollection>
                        ) else ()
                }
                {
                	let $CHQBK_PRINT_STATUS := $consultaChequeras/CHQBK_PRINT_STATUS
                    return
                    	if ( data($CHQBK_PRINT_STATUS) != "" ) then (
                        	<enquiryInputCollection>
                            	<columnName>PRINT.STATUS</columnName>
                            	<criteriaValue>{ data($CHQBK_PRINT_STATUS) }</criteriaValue>
                            	<operand>EQ</operand>
                        	</enquiryInputCollection>
                        ) else ()
                }                
            </WSCHECKBOOKREQUESTENQType>
        </ns0:Consultadechequerasporimprimir>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaChequeras as element(ns1:consultaChequeras) external;

xf:consultaChequerasIn($autenticacionRequestHeader,
    $consultaChequeras)