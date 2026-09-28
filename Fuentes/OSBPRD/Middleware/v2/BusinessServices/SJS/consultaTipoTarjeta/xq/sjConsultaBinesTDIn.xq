(:: pragma bea:global-element-parameter parameter="$sjConsultaTipoTarjeta1" element="ns1:sjConsultaTipoTarjeta" location="../xsd/sjConsultaTipoTarjeta.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadebinesTD" location="../../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaTipoTarjeta";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTipoTarjeta/xq/sjConsultaBinesTDIn/";

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

declare function xf:sjConsultaBinesTDIn($sjConsultaTipoTarjeta1 as element(ns1:sjConsultaTipoTarjeta))
    as element(ns0:ConsultadebinesTD) {
        <ns0:ConsultadebinesTD>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over(getUsername(data($sjConsultaTipoTarjeta1/ns1:USERNAME)),
                			data($sjConsultaTipoTarjeta1/ns1:USERNAME)) }</userName>
                <password>{ fn-bea:fail-over(getPassword(data($sjConsultaTipoTarjeta1/ns1:USERNAME)),
                			data($sjConsultaTipoTarjeta1/ns1:PASSWORD)) }</password>
            </WebRequestCommon>
            <WSCARDTYPEType>
                <enquiryInputCollection>
                    <columnName>BIN</columnName>
                    <criteriaValue>{ data($sjConsultaTipoTarjeta1/ns1:BIN_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCARDTYPEType>
        </ns0:ConsultadebinesTD>
};

declare variable $sjConsultaTipoTarjeta1 as element(ns1:sjConsultaTipoTarjeta) external;

xf:sjConsultaBinesTDIn($sjConsultaTipoTarjeta1)