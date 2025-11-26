(:: pragma bea:global-element-return element="ns0:loginSalesforceResponse" location="../xsd/loginSalesforceTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/loginSalesforceTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LoginSalesforce/xq/loginSalesforceOut/";

declare function xf:loginSalesforceOut($username as xs:string,
    $password as xs:string,
    $session as xs:string)
    as element(ns0:loginSalesforceResponse) {
        <ns0:loginSalesforceResponse>
            <SALESFORCE_INFO>
                <USERNAME>{ $username }</USERNAME>
                <PASSWORD>{ $password }</PASSWORD>
                <SESSION>{ $session }</SESSION>
            </SALESFORCE_INFO>
        </ns0:loginSalesforceResponse>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $session as xs:string external;

xf:loginSalesforceOut($username,
    $password,
    $session)
