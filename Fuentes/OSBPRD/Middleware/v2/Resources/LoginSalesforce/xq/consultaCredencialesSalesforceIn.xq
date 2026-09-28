(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/consultaCredencialesSalesforce/xsd/consultaCredencialesSalesforce_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCredencialesSalesforce";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LoginSalesforce/xq/consultaCredencialesSalesforceIn/";

declare function xf:consultaCredencialesSalesforceIn($sourceBank as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGOPAIS>{ $sourceBank }</ns0:PV_CODIGOPAIS>
        </ns0:InputParameters>
};

declare variable $sourceBank as xs:string external;

xf:consultaCredencialesSalesforceIn($sourceBank)