xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaChequeConfirmado" element="ns2:consultaChequeConfirmado" location="../../../../Business_Resources/consultaCheque/ConsultaChequeConfirmado/consultaChequeConfirmadoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadechequeconfirmado" location="../../../../Business_Resources/consultaCheque/Resources/XMLSchema_-1265051491.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaChequeConfirmado/xq/consultaChequeConfirmadoIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaChequeConfirmadoTypes";
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

declare function xf:consultaChequeConfirmadoIn($requestHeader as element(ns0:RequestHeader),
    $consultaChequeConfirmado as element(ns2:consultaChequeConfirmado))
    as element(ns1:Consultadechequeconfirmado) {
        <ns1:Consultadechequeconfirmado>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSLATAMAGCHEQUECONFIRMBROWENQType>
            	<enquiryInputCollection>
               		<columnName>CHQ.ACCOUNT</columnName>
               		<criteriaValue>{ data($consultaChequeConfirmado/ACCOUNT_NUMBER) }</criteriaValue>
               		<operand>EQ</operand>
            	</enquiryInputCollection>          	
            	{
		            if ( exists($consultaChequeConfirmado/CHEQUE_NUMBER/text()) ) then (
			            <enquiryInputCollection>
			               <columnName>CHEQUE.NO</columnName>
			               <criteriaValue>{ data($consultaChequeConfirmado/CHEQUE_NUMBER) }</criteriaValue>
			               <operand>EQ</operand>
			            </enquiryInputCollection>
		            ) 
		            else ()
	            }
	            {
		            if ( exists($consultaChequeConfirmado/RESERVE_FUNDS_YES_NO/text()) ) then (         
			            <enquiryInputCollection>
			               <columnName>RESERVE.FUNDS.Y.N</columnName>
			               <criteriaValue>{ data($consultaChequeConfirmado/RESERVE_FUNDS_YES_NO) }</criteriaValue>
			               <operand>EQ</operand>
			            </enquiryInputCollection>
			    	) 
			    	else ()
		    	}
            </WSLATAMAGCHEQUECONFIRMBROWENQType>
        </ns1:Consultadechequeconfirmado>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaChequeConfirmado as element(ns2:consultaChequeConfirmado) external;

xf:consultaChequeConfirmadoIn($requestHeader,
    $consultaChequeConfirmado)