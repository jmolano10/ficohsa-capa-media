(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaarchdeudoresporcontratoResponse" element="ns0:ConsultaarchdeudoresporcontratoResponse" location="../Resources/XMLSchema_-525487073.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetarchdeudoreserror" location="../Resources/XMLSchema_-525487073.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/archivosConvenios/consultaDetalleArchivoDeudores/consultaDetalleArchivoErrorIn/";

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

declare function xf:consultaDetalleArchivoErrorIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $consultaarchdeudoresporcontratoResponse as element(ns0:ConsultaarchdeudoresporcontratoResponse))
    as element(ns0:Consultadedetarchdeudoreserror) {
        <ns0:Consultadedetarchdeudoreserror>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <FICOHNAGDEBAFFFILEUPLOADERRType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $MAPID in $consultaarchdeudoresporcontratoResponse/FICOHNAGFILESTATUSDEBAFFENQType[1]/gFICOHNAGFILESTATUSDEBAFFENQDetailType/mFICOHNAGFILESTATUSDEBAFFENQDetailType[1]/MAPID
                        return
                            <criteriaValue>{ data($MAPID) }</criteriaValue>
                    }
                    <operand>BW</operand>
                </enquiryInputCollection>
            </FICOHNAGDEBAFFFILEUPLOADERRType>
        </ns0:Consultadedetarchdeudoreserror>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $consultaarchdeudoresporcontratoResponse as element(ns0:ConsultaarchdeudoresporcontratoResponse) external;

xf:consultaDetalleArchivoErrorIn($autenticacionRequestHeader,
    $consultaarchdeudoresporcontratoResponse)