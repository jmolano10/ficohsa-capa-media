(:: pragma bea:global-element-parameter parameter="$consultaEstadoChequeCertificado" element="ns1:consultaEstadoChequeCertificado" location="consultaEstadoChequeCertificadoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadechqcertificado" location="../Resources/XMLSchema_1194496794.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoChequeCertificadoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/ConsultaEstadoChequeCertificado/consultaEstadoChequeCertificadoIn/";

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

declare function xf:consultaEstadoChequeCertificadoIn($consultaEstadoChequeCertificado as element(ns1:consultaEstadoChequeCertificado),
    $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader))
    as element(ns0:Consultadechqcertificado) {
        <ns0:Consultadechqcertificado>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <FICOCERTCHQSTATUSType>
                <enquiryInputCollection>
                    <columnName>ACCOUNT.NO</columnName>
                    <criteriaValue>{ data($consultaEstadoChequeCertificado/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
		        <enquiryInputCollection>
		            <columnName>CHEQUE.NO</columnName>
		            <criteriaValue>{ data($consultaEstadoChequeCertificado/CHEQUE_NUMBER) }</criteriaValue>
		            <operand>EQ</operand>
		        </enquiryInputCollection>                
            </FICOCERTCHQSTATUSType>
        </ns0:Consultadechqcertificado>
};

declare variable $consultaEstadoChequeCertificado as element(ns1:consultaEstadoChequeCertificado) external;
declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;

xf:consultaEstadoChequeCertificadoIn($consultaEstadoChequeCertificado,
    $autenticacionRequestHeader)