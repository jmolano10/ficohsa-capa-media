xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cambiaEstadoAccesoUsuario" element="ns2:cambiaEstadoAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:FicohsaUserOperation" location="../../../BusinessServices/T24/GestionAccesosUsuarios/xsd/XMLSchema_531731114.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CambiaEstadoAccesoUsuario/xq/ficohsaUserOperationHNIn/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:ficohsaUserOperationHNIn($requestHeader as element(ns0:RequestHeader),
    $cambiaEstadoAccesoUsuario as element(ns2:cambiaEstadoAccesoUsuario))
    as element(ns1:FicohsaUserOperation) {
        <ns1:FicohsaUserOperation>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FICOUSERFICOUSRWSType id = "{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/APPLICATION_USER) }">
                <TYPEOPER>{ data($cambiaEstadoAccesoUsuario/cambiaEstadoAccesoUsuario/STATUS) }</TYPEOPER>
            </FICOUSERFICOUSRWSType>
        </ns1:FicohsaUserOperation>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $cambiaEstadoAccesoUsuario as element(ns2:cambiaEstadoAccesoUsuario) external;

xf:ficohsaUserOperationHNIn($requestHeader,
    $cambiaEstadoAccesoUsuario)