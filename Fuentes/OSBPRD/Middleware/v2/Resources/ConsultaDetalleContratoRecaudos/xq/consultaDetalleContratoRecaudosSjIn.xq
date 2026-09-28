(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleContratoRecaudos" element="ns2:consultaDetalleContratoRecaudos" location="../xsd/consultaDetalleContratoRecaudosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaDetalleContratoRecaudos" location="../../../BusinessServices/SJS/consultaDetalleContratoRecaudos/xsd/sjConsultaDetalleContratoRecaudosTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaDetalleContratoRecaudosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleContratoRecaudos/xq/consultaDetalleContratoRecaudosSjIn/";

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
 
declare function xf:consultaDetalleContratoRecaudosSjIn($requestHeader as element(ns0:RequestHeader),
    $consultaDetalleContratoRecaudos as element(ns2:consultaDetalleContratoRecaudos))
    as element(ns1:sjConsultaDetalleContratoRecaudos) {
        <ns1:sjConsultaDetalleContratoRecaudos>
            <USERNAME>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
											data($requestHeader/Authentication/UserName)) }</USERNAME>
            <PASSWORD>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
            								data($requestHeader/Authentication/Password)) }</PASSWORD>
            {
                for $CONTRACT_ID in $consultaDetalleContratoRecaudos/CONTRACT_ID
                return
                    <CONTRACT_ID>{ data($CONTRACT_ID) }</CONTRACT_ID>
            }
        </ns1:sjConsultaDetalleContratoRecaudos>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaDetalleContratoRecaudos as element(ns2:consultaDetalleContratoRecaudos) external;

xf:consultaDetalleContratoRecaudosSjIn($requestHeader,
    $consultaDetalleContratoRecaudos)