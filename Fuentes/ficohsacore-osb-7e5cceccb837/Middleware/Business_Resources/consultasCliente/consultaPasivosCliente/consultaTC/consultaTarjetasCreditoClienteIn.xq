(:: pragma bea:global-element-parameter parameter="$consultaTarjetaCreditoTypeRequest1" element="ns1:ConsultaTarjetaCreditoTypeRequest" location="ConsultaTarjetaCreditoCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Tarjetasdecreditoporcliente" location="../../Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "ConsultaTarjetaCreditoCliente";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaTarjetasCreditoClienteIn/";

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

declare function xf:consultaTarjetasCreditoClienteIn($consultaTarjetaCreditoTypeRequest1 as element(ns1:ConsultaTarjetaCreditoTypeRequest))
    as element(ns0:Tarjetasdecreditoporcliente) {
        <ns0:Tarjetasdecreditoporcliente>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($consultaTarjetaCreditoTypeRequest1/ns1:AUTHENTICATION/ns1:USERNAME[1])), 
												data($consultaTarjetaCreditoTypeRequest1/ns1:AUTHENTICATION/ns1:USERNAME[1])) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($consultaTarjetaCreditoTypeRequest1/ns1:AUTHENTICATION/ns1:USERNAME[1])),
                								data($consultaTarjetaCreditoTypeRequest1/ns1:AUTHENTICATION/ns1:PASSWORD[1])) }</password>
            </WebRequestCommon>
            <FICOLISTCLIENTCARDCPType>
                <enquiryInputCollection>
                    <columnName>CLIENT.ID</columnName>
                    <criteriaValue>{ data($consultaTarjetaCreditoTypeRequest1/ns1:PARAMETERS/ns1:CUSTOMERID[1]) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOLISTCLIENTCARDCPType>
        </ns0:Tarjetasdecreditoporcliente>
};

declare variable $consultaTarjetaCreditoTypeRequest1 as element(ns1:ConsultaTarjetaCreditoTypeRequest) external;

xf:consultaTarjetasCreditoClienteIn($consultaTarjetaCreditoTypeRequest1)