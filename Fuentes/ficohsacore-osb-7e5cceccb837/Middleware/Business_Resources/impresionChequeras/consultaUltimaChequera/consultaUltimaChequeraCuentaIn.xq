(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaChequeras1" element="ns1:consultaChequeras" location="../ConsultaChequeras/consultaChequerasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaUltimaChequera" location="../Resources/XMLSchema_1756805255.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaChequerasTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/impresionChequeras/consultaUltimaChequera/consultaUltimaChequeraIn/";

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

declare function xf:consultaUltimaChequeraIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $consultaChequeras1 as element(ns1:consultaChequeras))
    as element(ns0:ConsultaUltimaChequera) {
        <ns0:ConsultaUltimaChequera>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSCHECKBOOKREQUESTENQLASTType>
                    {
                        let $ACCOUNT_NUMBER := $consultaChequeras1/ACCOUNT_NUMBER
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
                	let $CHEQUEBOOK_STATUS := $consultaChequeras1/CHEQUEBOOK_STATUS
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
                	let $CHQBK_PRINT_STATUS := $consultaChequeras1/CHQBK_PRINT_STATUS
                    return
                    	if ( data($CHQBK_PRINT_STATUS) != "" ) then (
                        	<enquiryInputCollection>
                            	<columnName>PRINT.STATUS</columnName>
                            	<criteriaValue>{ data($CHQBK_PRINT_STATUS) }</criteriaValue>
                            	<operand>EQ</operand>
                        	</enquiryInputCollection>
                        ) else ()
                }
            </WSCHECKBOOKREQUESTENQLASTType>
        </ns0:ConsultaUltimaChequera>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaChequeras1 as element(ns1:consultaChequeras) external;

xf:consultaUltimaChequeraIn($autenticacionRequestHeader1,
    $consultaChequeras1)