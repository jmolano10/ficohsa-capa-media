xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$modificaAccesoUsuario" element="ns2:modificaAccesoUsuario" location="../../GestionAccesosUsuarios/xsd/gestionAccesosUsuariosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:UpdateUser" location="../../../BusinessServices/CREDITFORCENI/GestionAccesosUsuarios/xsd/XMLSchema_-336569572.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaAccesoUsuario/xq/updateUserCFNIIn/";
declare namespace ns0 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/gestionAccesosUsuariosTypes";
declare namespace ns1 = "http://www.creditforce.com/SOA";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns3 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract.BackEnd.Collection";

declare function xf:updateUserCFNIIn($modificaAccesoUsuario as element(ns2:modificaAccesoUsuario),
    $token as xs:string,
    $userName as xs:string)
    as element(ns1:UpdateUser) {
        <ns1:UpdateUser>
            <ns1:userReq>
                <ns3:Token>{ $token }</ns3:Token>
                <ns3:User_Name>{ $userName }</ns3:User_Name>
                <ns3:User>
                    <ns3:Application_User>{ data($modificaAccesoUsuario/modificaAccesoUsuario/APPLICATION_USER) }</ns3:Application_User>
                    <ns3:Email>{ data($modificaAccesoUsuario/modificaAccesoUsuario/EMAIL) }</ns3:Email>
                    <ns3:Full_Name>{ concat( data($modificaAccesoUsuario/modificaAccesoUsuario/FIRST_NAME) , ' ', data($modificaAccesoUsuario/modificaAccesoUsuario/SECOND_NAME), ' ', data($modificaAccesoUsuario/modificaAccesoUsuario/FIRST_LASTNAME), ' ',data($modificaAccesoUsuario/modificaAccesoUsuario/SECOND_LASTNAME)) }</ns3:Full_Name>
                    <ns3:Module>
                        {
                            for $MODULE in $modificaAccesoUsuario/modificaAccesoUsuario/MODULES/MODULE
                            return
                                <ns3:Module>
                                    {
                                        for $DESCRIPTION in $MODULE/DESCRIPTION
                                        return
                                            <ns3:Description>{ data($DESCRIPTION) }</ns3:Description>
                                    }
                                    {
                                        for $MODULE_ID in $MODULE/MODULE_ID
                                        return
                                            <ns3:Module_Id>{ data($MODULE_ID) }</ns3:Module_Id>
                                    }
                                </ns3:Module>
                        }
                    </ns3:Module>
                    <ns3:Role>
                        {
                            for $ROLE in $modificaAccesoUsuario/modificaAccesoUsuario/ROLES/ROLE
                            return
                                <ns3:Role>
                                    {
                                        for $DESCRIPTION in $ROLE/DESCRIPTION
                                        return
                                            <ns3:Description>{ data($DESCRIPTION) }</ns3:Description>
                                    }
                                    {
                                        for $MODULE_ID in $ROLE/MODULE_ID
                                        return
                                            <ns3:Module_Id>{ data($MODULE_ID) }</ns3:Module_Id>
                                    }
                                    {
                                        for $ROLE_ID in $ROLE/ROLE_ID
                                        return
                                            <ns3:Role_Id>{ data($ROLE_ID) }</ns3:Role_Id>
                                    }
                                </ns3:Role>
                        }
                    </ns3:Role>
                    <ns3:Security_Provider>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[KEY = "DOMAIN_DESCRIPTION"]/VALUE) }</ns3:Security_Provider>
                    <ns3:Security_Provider_Id>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[KEY = "DOMAIN"]/VALUE) }</ns3:Security_Provider_Id>
                    <ns3:Status>{ data($modificaAccesoUsuario/modificaAccesoUsuario/ADDITIONAL_DATA/KV_PAIR[KEY = "STATUS"]/VALUE) }</ns3:Status>
                </ns3:User>
            </ns1:userReq>
        </ns1:UpdateUser>
};

declare variable $modificaAccesoUsuario as element(ns2:modificaAccesoUsuario) external;
declare variable $token as xs:string external;
declare variable $userName as xs:string external;

xf:updateUserCFNIIn($modificaAccesoUsuario,
    $token,
    $userName)