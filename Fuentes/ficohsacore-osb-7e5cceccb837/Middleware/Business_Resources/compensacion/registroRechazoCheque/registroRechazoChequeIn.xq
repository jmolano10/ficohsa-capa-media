(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registroRechazoChequeCompensacion" element="ns0:registroRechazoChequeCompensacion" location="registroRechazoChequeCompensacionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Registroderechazodecheque" location="../resources/XMLSchema_1569843523.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registroRechazoChequeCompensacionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/compensacion/registroRechazoCheque/registroRechazoChequeIn/";

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

declare function xf:registroRechazoChequeIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $registroRechazoChequeCompensacion as element(ns0:registroRechazoChequeCompensacion))
    as element(ns1:Registroderechazodecheque) {
        <ns1:Registroderechazodecheque>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
	         <OfsFunction>
	            <gtsControl></gtsControl>
	            <messageId></messageId>
	            <noOfAuth>0</noOfAuth>
	            <replace></replace>
	         </OfsFunction>
	         <FICOINWARDCLEARINGCHEQREJNOCOMMType id="">
	            <RECORDTYPE></RECORDTYPE>
	             <PREVALFLAG></PREVALFLAG>
	            <CHEQUETYPE></CHEQUETYPE>
	            <ROUTECODE></ROUTECODE>
	            <CLGACCOUNTNUMBER>{ data($registroRechazoChequeCompensacion/ACCOUNT_NUMBER) }</CLGACCOUNTNUMBER>
	            <T24ACCOUNTNUMBER></T24ACCOUNTNUMBER>
	            <CHEQUENUMBER>{ data($registroRechazoChequeCompensacion/CHEQUE_NUMBER) }</CHEQUENUMBER>
	            <CHEQUECCY>{ data($registroRechazoChequeCompensacion/CURRENCY) }</CHEQUECCY>
	            <CHEQUEAMOUNT>{ data($registroRechazoChequeCompensacion/AMOUNT) }</CHEQUEAMOUNT>
	            <CLRINGCENTRCODE>{ data($registroRechazoChequeCompensacion/CLEARING_CENTER_CODE) }</CLRINGCENTRCODE>
	            <STATUS></STATUS>
	            <REJECTIONCODE>{ data($registroRechazoChequeCompensacion/REJECTION_ID) }</REJECTIONCODE>
	            <REJECTIONREASON>{ data($registroRechazoChequeCompensacion/REJECTION_MOTIVE) }</REJECTIONREASON>
	            <REJECTIONTYPE>{ data($registroRechazoChequeCompensacion/REJECTION_TYPE) }</REJECTIONTYPE>
	             <gDESCRIPTION g="0">
	               <DESCRIPTION>{ data($registroRechazoChequeCompensacion/DESCRIPTION) }</DESCRIPTION>
	            </gDESCRIPTION>
	            <TOTALCOMMISSION></TOTALCOMMISSION>
	             <COMMCOLLECTED></COMMCOLLECTED>
	            <COMMBALANCE></COMMBALANCE>
	            <COMMSTATUS></COMMSTATUS>
	            <gCHQTRANREFNO g="0">
	               <CHQTRANREFNO></CHQTRANREFNO>
	            </gCHQTRANREFNO>
	            <gCOMMTRANREFNO g="0">
	               <COMMTRANREFNO></COMMTRANREFNO>
	            </gCOMMTRANREFNO>
	            <DATECHQRECEIVED></DATECHQRECEIVED>
	            <RESPONSERESULT></RESPONSERESULT>
	           <RESERVED7></RESERVED7>
	            <RESERVED6></RESERVED6>
	            <RESERVED5></RESERVED5>
	            <RESERVED4></RESERVED4>
	           <RESERVED3></RESERVED3>
	             <RESERVED2></RESERVED2>
	            <RESERVED1></RESERVED1>
	            <RECORDSTATUS></RECORDSTATUS>
	            <CURRNO></CURRNO>
	           <AUTHORISER></AUTHORISER>
	           <COCODE></COCODE>
	            <DEPTCODE></DEPTCODE>
	            <AUDITORCODE></AUDITORCODE>
	           <AUDITDATETIME></AUDITDATETIME>
	         </FICOINWARDCLEARINGCHEQREJNOCOMMType>            
        </ns1:Registroderechazodecheque>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $registroRechazoChequeCompensacion as element(ns0:registroRechazoChequeCompensacion) external;

xf:registroRechazoChequeIn($autenticacionRequestHeader1,
    $registroRechazoChequeCompensacion)