(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/actualizaCredencialesSalesforce/xsd/actualizaCredencialesSalesforce_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaCredencialesSalesforce";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarFinanciamiento/xq/actualizaCredencialesSalesforceIn/";

declare function xf:actualizaCredencialesSalesforceIn($sourceBank as xs:string,
    $sesion as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_SESION>{ $sesion }</ns0:PV_SESION>
            <ns0:PV_CODIGOPAIS>{ $sourceBank }</ns0:PV_CODIGOPAIS>
        </ns0:InputParameters>
};

declare variable $sourceBank as xs:string external;
declare variable $sesion as xs:string external;

xf:actualizaCredencialesSalesforceIn($sourceBank,
    $sesion)
