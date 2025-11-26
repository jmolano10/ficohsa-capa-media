(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaImagenFirmas" element="ns0:consultaImagenFirmas" location="consultaImagenFirmasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadeimagenes" location="../Resources/XMLSchema_1601969511.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaImagenFirmasTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasImagen/ConsultaImagenFirmas/consultaImagenFirmasIn/";

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

declare function xf:consultaImagenFirmasIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaImagenFirmas as element(ns0:consultaImagenFirmas))
    as element(ns1:Consultadeimagenes) {
        <ns1:Consultadeimagenes>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSFICOIMAGEVIEWDESCType>
                <enquiryInputCollection>
                    <columnName>IMAGE.REFERENCE</columnName>
                    <criteriaValue>{ data($consultaImagenFirmas/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOIMAGEVIEWDESCType>
        </ns1:Consultadeimagenes>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaImagenFirmas as element(ns0:consultaImagenFirmas) external;

xf:consultaImagenFirmasIn($autenticacionRequestHeader,
    $consultaImagenFirmas)