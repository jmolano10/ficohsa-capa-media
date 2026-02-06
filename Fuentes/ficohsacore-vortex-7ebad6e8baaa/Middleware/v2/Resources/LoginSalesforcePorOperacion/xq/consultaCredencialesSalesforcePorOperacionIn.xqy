xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$loginSalesforce1" element="ns1:loginSalesforce" location="../../LoginSalesforce/xsd/loginSalesforceTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/consultaCredencialesSalesforcePorOperacion/xsd/consultaCredencialesSaleForcePorOperacion_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/loginSalesforceTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCredencialesSaleForcePorOperacion";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LoginSalesforcePorOperacion/xq/consultaCredencialesSalesforcePorOperacionIn/";

declare function xf:consultaCredencialesSalesforcePorOperacionIn($loginSalesforce1 as element(ns1:loginSalesforce),
    $pais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGOPAIS>{ $pais }</ns0:PV_CODIGOPAIS>
            {
                for $OPERATION in $loginSalesforce1/SALESFORCE_INFO/OPERATION
                return
                    <ns0:PV_OPERATION>{ data($OPERATION) }</ns0:PV_OPERATION>
            }
        </ns0:InputParameters>
};

declare variable $loginSalesforce1 as element(ns1:loginSalesforce) external;
declare variable $pais as xs:string external;

xf:consultaCredencialesSalesforcePorOperacionIn($loginSalesforce1,
    $pais)