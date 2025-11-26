(:: pragma bea:global-element-return element="ns0:loginSalesforce" location="../../LoginSalesforce/xsd/loginSalesforceTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/loginSalesforceTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LoginSalesforcePorOperacion/xq/loginSaleforcePorOperacionIn/";

declare function xf:loginSaleforcePorOperacionIn($username as xs:string,
    $password as xs:string,
    $operacion as xs:string)
    as element(ns0:loginSalesforce) {
        <ns0:loginSalesforce>
            <FORCE_NEW_SESSION>true</FORCE_NEW_SESSION>
            <SALESFORCE_INFO>
                <USERNAME>{ $username }</USERNAME>
                <PASSWORD>{ $password }</PASSWORD>
                <OPERATION>{ $operacion }</OPERATION>
            </SALESFORCE_INFO>
        </ns0:loginSalesforce>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $operacion as xs:string external;

xf:loginSaleforcePorOperacionIn($username,
    $password,
    $operacion)
