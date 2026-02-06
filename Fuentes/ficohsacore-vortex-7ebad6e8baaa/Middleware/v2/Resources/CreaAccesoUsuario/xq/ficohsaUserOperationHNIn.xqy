xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$creaAccesoUsuario" element="ns2:creaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:FicohsaUserOperation" location="../../../BusinessServices/T24/GestionAccesosUsuarios/xsd/XMLSchema_531731114.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaAccesoUsuario/xq/ficohsaUserOperationHNIn/";
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
    $creaAccesoUsuario as element(ns2:creaAccesoUsuario))
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
            <FICOUSERFICOUSRWSType id = "{ data($creaAccesoUsuario/creaAccesoUsuario/APPLICATION_USER) }">
                <USERNAME>{ concat( data($creaAccesoUsuario/creaAccesoUsuario/FIRST_NAME) , ' ', data($creaAccesoUsuario/creaAccesoUsuario/SECOND_NAME), ' ', data($creaAccesoUsuario/creaAccesoUsuario/FIRST_LASTNAME), ' ',data($creaAccesoUsuario/creaAccesoUsuario/SECOND_LASTNAME)) }</USERNAME>
                <SIGNONNAME>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "SIGN_ON_NAME"]/VALUE)) }</SIGNONNAME>
                <DEPARTMENTCODE>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "DEPARTAMENT_CODE"]/VALUE)) }</DEPARTMENTCODE>
                <INITAPPLICATION>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "MENU"]/VALUE)) }</INITAPPLICATION>
                <APPLICATION>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "ROL"]/VALUE)) }</APPLICATION>
                <AGENCYCODE>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "AGENCY"]/VALUE)) }</AGENCYCODE>
                <FRONTOFFICE>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "FRONT_OFFICE"]/VALUE)) }</FRONTOFFICE>
                <CHANNELTYPE>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "CHANNEL_TYPE"]/VALUE)) }</CHANNELTYPE>
                <TYPEOPER>N</TYPEOPER>
                <DAOAREA>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "DAO_AREA"]/VALUE)) }</DAOAREA>
                <DAONAME>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "DAO_NAME"]/VALUE)) }</DAONAME>
                <DAODELIVERYP>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "DAO_DELIVERY"]/VALUE)) }</DAODELIVERYP>
                <DAOLEVEL>{ (data($creaAccesoUsuario/creaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[fn:upper-case(KEY) = "DAO_LEVEL"]/VALUE)) }</DAOLEVEL>
            </FICOUSERFICOUSRWSType>
        </ns1:FicohsaUserOperation>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $creaAccesoUsuario as element(ns2:creaAccesoUsuario) external;

xf:ficohsaUserOperationHNIn($requestHeader,
    $creaAccesoUsuario)