(:: pragma bea:global-element-return element="ns0:loginSalesforce" location="../../LoginSalesforce/xsd/loginSalesforceTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/loginSalesforceTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/xq/credencialSalesforceIn/";

declare function xf:credencialSalesforceIn($createNewSession as xs:boolean,
    $username as xs:string,
    $password as xs:string)
    as element(ns0:loginSalesforce) {
        <ns0:loginSalesforce>
            <FORCE_NEW_SESSION>{ $createNewSession }</FORCE_NEW_SESSION>
            <SALESFORCE_INFO>
                <USERNAME>{ $username }</USERNAME>
                <PASSWORD>{ $password }</PASSWORD>
            </SALESFORCE_INFO>
        </ns0:loginSalesforce>
};

declare variable $createNewSession as xs:boolean external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;

xf:credencialSalesforceIn($createNewSession,
    $username,
    $password)
