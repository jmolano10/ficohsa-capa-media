xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaEstadoTransaccion1" element="ns1:consultaEstadoTransaccion" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaEstadoTransaccionACH" location="../../../BusinessServices/T24/ConsultaEstadoTransaccionACH/xsd/ConsultaEstadoTransaccionACHTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccion/xq/consultaEstadoTransaccionACH_T24_In/";


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


declare function xf:consultaEstadoTransaccionACH_T24_In($requestHeader1 as element(ns2:RequestHeader),
    $consultaEstadoTransaccion1 as element(ns1:consultaEstadoTransaccion))
    as element(ns0:ConsultaEstadoTransaccionACH) {
        <ns0:ConsultaEstadoTransaccionACH>
            <WebRequestCommon>
               <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <FICOACHGETSTATUSTICKETWSType>            
                <enquiryInputCollection>
                	<columnName>TICKET</columnName>
                    <criteriaValue>{ data($consultaEstadoTransaccion1/TICKET) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>                    
                    <columnName>TRANSACTION.TYPE</columnName>
                    <criteriaValue>{  data($consultaEstadoTransaccion1/TRANSACTION_TYPE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOACHGETSTATUSTICKETWSType>
        </ns0:ConsultaEstadoTransaccionACH>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $consultaEstadoTransaccion1 as element(ns1:consultaEstadoTransaccion) external;

xf:consultaEstadoTransaccionACH_T24_In($requestHeader1,
    $consultaEstadoTransaccion1)