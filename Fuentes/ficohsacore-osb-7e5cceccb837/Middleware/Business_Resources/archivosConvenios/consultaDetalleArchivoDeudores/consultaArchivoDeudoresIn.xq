(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleArchivoDeudores" element="ns0:consultaDetalleArchivoDeudores" location="consultaDetalleArchivoDeudoresTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultaarchdeudoresporcontrato" location="../Resources/XMLSchema_-525487073.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleArchivoDeudoresTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/archivosConvenios/consultaDetalleArchivoDeudores/consultaArchivoDeudoresIn/";

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

declare function xf:consultaArchivoDeudoresIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaDetalleArchivoDeudores as element(ns0:consultaDetalleArchivoDeudores))
    as element(ns1:Consultaarchdeudoresporcontrato) {
        <ns1:Consultaarchdeudoresporcontrato>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <FICOHNAGFILESTATUSDEBAFFENQType>
                <enquiryInputCollection>
                    <columnName>AGR.CONTRACT.NO</columnName>
                    <criteriaValue>{ data($consultaDetalleArchivoDeudores/CONTRACT_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>FILE.NAME</columnName>
                    <criteriaValue>{ data($consultaDetalleArchivoDeudores/FILE_NAME) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>                
            </FICOHNAGFILESTATUSDEBAFFENQType>
        </ns1:Consultaarchdeudoresporcontrato>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaDetalleArchivoDeudores as element(ns0:consultaDetalleArchivoDeudores) external;

xf:consultaArchivoDeudoresIn($autenticacionRequestHeader,
    $consultaDetalleArchivoDeudores)