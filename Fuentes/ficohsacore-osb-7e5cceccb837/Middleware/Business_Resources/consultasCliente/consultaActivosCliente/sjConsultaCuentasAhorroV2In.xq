(:: pragma bea:global-element-parameter parameter="$sjConsultaActivosClienteRequest1" element="ns0:sjConsultaActivosClienteRequest" location="sjConsultaActivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaCuentaAhorroxCliente" location="ConsultaCuentasCliente/xsd/services_1.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/consultaActivosAhorrosClienteV2In/";

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

declare function xf:consultaActivosAhorrosClienteV2In($sjConsultaActivosClienteRequest1 as element(ns0:sjConsultaActivosClienteRequest))
    as element(ns1:ConsultaCuentaAhorroxCliente) {
        <ns1:ConsultaCuentaAhorroxCliente>
           <WebRequestCommon>
                 <userName>{ data($sjConsultaActivosClienteRequest1/ns0:USERNAME) }</userName>
                <password>{ data($sjConsultaActivosClienteRequest1/ns0:PASSWORD) }</password>
            </WebRequestCommon>
            <WSFICOLINKSAVINGSACCOUNTType>
                <enquiryInputCollection>
                    <columnName>CUSTOMER</columnName>
                    <criteriaValue>{ data($sjConsultaActivosClienteRequest1/ns0:CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOLINKSAVINGSACCOUNTType>
        </ns1:ConsultaCuentaAhorroxCliente>
};

declare variable $sjConsultaActivosClienteRequest1 as element(ns0:sjConsultaActivosClienteRequest) external;

xf:consultaActivosAhorrosClienteV2In($sjConsultaActivosClienteRequest1)