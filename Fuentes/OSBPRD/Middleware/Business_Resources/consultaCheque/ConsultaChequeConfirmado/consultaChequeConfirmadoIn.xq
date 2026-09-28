(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaChequeConfirmado1" element="ns2:consultaChequeConfirmado" location="consultaChequeConfirmadoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadechequeconfirmado" location="../Resources/XMLSchema_-1265051491.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaChequeConfirmadoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/ConsultaChequeConfirmado/consultaChequeConfirmadoIn/";

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

declare function xf:consultaChequeConfirmadoIn($autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader),
    $consultaChequeConfirmado1 as element(ns2:consultaChequeConfirmado))
    as element(ns0:Consultadechequeconfirmado) {
        <ns0:Consultadechequeconfirmado>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSLATAMAGCHEQUECONFIRMBROWENQType>
            	<enquiryInputCollection>
               		<columnName>CHQ.ACCOUNT</columnName>
               		<criteriaValue>{ data($consultaChequeConfirmado1/ACCOUNT_NUMBER) }</criteriaValue>
               		<operand>EQ</operand>
            	</enquiryInputCollection>          	
            	{
		            if ( exists($consultaChequeConfirmado1/CHEQUE_NUMBER/text()) ) then (
			            <enquiryInputCollection>
			               <columnName>CHEQUE.NO</columnName>
			               <criteriaValue>{ data($consultaChequeConfirmado1/CHEQUE_NUMBER) }</criteriaValue>
			               <operand>EQ</operand>
			            </enquiryInputCollection>
		            ) 
		            else ()
	            }
	            {
		            if ( exists($consultaChequeConfirmado1/RESERVE_FUNDS_YES_NO/text()) ) then (         
			            <enquiryInputCollection>
			               <columnName>RESERVE.FUNDS.Y.N</columnName>
			               <criteriaValue>{ data($consultaChequeConfirmado1/RESERVE_FUNDS_YES_NO) }</criteriaValue>
			               <operand>EQ</operand>
			            </enquiryInputCollection>
			    	) 
			    	else ()
		    	}
            </WSLATAMAGCHEQUECONFIRMBROWENQType>
        </ns0:Consultadechequeconfirmado>
};

declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;
declare variable $consultaChequeConfirmado1 as element(ns2:consultaChequeConfirmado) external;

xf:consultaChequeConfirmadoIn($autenticacionRequestHeader1,
    $consultaChequeConfirmado1)