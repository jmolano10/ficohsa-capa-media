xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/updateAccountTypes";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/updateAccountTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/UpdateAccount";
(:: import schema at "../../../../ProviderServices/XSD/UpdateAccount/UpdateAccount_sp.xsd" ::)

declare variable $UpdateAccountRequest as element() (:: schema-element(ns1:updateAccountRequest) ::) external;

declare function local:func($UpdateAccountRequest as element() (:: schema-element(ns1:updateAccountRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PV_NUMERO_CUENTA>{fn:data($UpdateAccountRequest/ns1:AccountNumber)}</ns2:PV_NUMERO_CUENTA>
        <ns2:PV_USUARIO_MODIFICA>{fn:data($UpdateAccountRequest/ns1:InterfaceUser)}</ns2:PV_USUARIO_MODIFICA>
        <ns2:PV_INACTIVA>
        {
            if(fn:data($UpdateAccountRequest/ns1:AccountStatus)= 0)then(
              'A'
            )else if (fn:data($UpdateAccountRequest/ns1:AccountStatus)= 1) then(
              'I'
            )else(' ')
        }
        </ns2:PV_INACTIVA>
    </ns2:InputParameters>
};

local:func($UpdateAccountRequest)