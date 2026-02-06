xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaAccesoUsuario" element="ns2:consultaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:SelectUserValue" location="../../../BusinessServices/T24/GestionAccesosUsuarios/xsd/XMLSchema_531731114.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAccesoUsuario/xq/selectUserValueHNIn/";

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

declare function xf:selectUserValueHNIn($requestHeader as element(ns0:RequestHeader),
    $consultaAccesoUsuario as element(ns2:consultaAccesoUsuario))
    as element(ns1:SelectUserValue) {
        <ns1:SelectUserValue>
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
            <FICOENQVALUSERWSType>
                <enquiryInputCollection>
                    <columnName>USER.ID</columnName>
                    <criteriaValue>{ data($consultaAccesoUsuario/consultaAccesoUsuario/APPLICATION_USER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOENQVALUSERWSType>
        </ns1:SelectUserValue>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaAccesoUsuario as element(ns2:consultaAccesoUsuario) external;

xf:selectUserValueHNIn($requestHeader,
    $consultaAccesoUsuario)