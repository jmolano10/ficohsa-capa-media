xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$modificaAccesoUsuario" element="ns2:modificaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:FicohsaUserOperation" location="../../../BusinessServices/T24/GestionAccesosUsuarios/xsd/XMLSchema_531731114.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaAccesoUsuario/xq/ficohsaUserOperationHNIn/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/kvpType";

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
    $modificaAccesoUsuario as element(ns2:modificaAccesoUsuario))
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
            <FICOUSERFICOUSRWSType id = "{ data($modificaAccesoUsuario/modificaAccesoUsuario/APPLICATION_USER) }">
                <DEPARTMENTCODE>{ (data($modificaAccesoUsuario/modificaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "DEPARTAMENT_CODE"]/VALUE)) }</DEPARTMENTCODE>
                <INITAPPLICATION>{ (data($modificaAccesoUsuario/modificaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "MENU"]/VALUE)) }</INITAPPLICATION>
                <APPLICATION>{ (data($modificaAccesoUsuario/modificaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "ROL"]/VALUE)) }</APPLICATION>
                <AGENCYCODE>{ (data($modificaAccesoUsuario/modificaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "AGENCY"]/VALUE)) }</AGENCYCODE>
                <FRONTOFFICE>{ (data($modificaAccesoUsuario/modificaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "FRONT_OFFICE"]/VALUE)) }</FRONTOFFICE>
                <CHANNELTYPE>{ (data($modificaAccesoUsuario/modificaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "CHANNEL_TYPE"]/VALUE)) }</CHANNELTYPE>
                <TYPEOPER>P</TYPEOPER>
            </FICOUSERFICOUSRWSType>
        </ns1:FicohsaUserOperation>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $modificaAccesoUsuario as element(ns2:modificaAccesoUsuario) external;

xf:ficohsaUserOperationHNIn($requestHeader,
    $modificaAccesoUsuario)