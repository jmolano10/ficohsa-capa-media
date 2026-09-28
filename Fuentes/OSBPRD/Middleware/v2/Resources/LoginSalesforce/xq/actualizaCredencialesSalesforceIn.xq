(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/actualizaCredencialesSalesforce/xsd/actualizaCredencialesSalesforce_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaCredencialesSalesforce";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LoginSalesforce/xq/actualizaCredencialesSalesforceIn/";

declare function xf:actualizaCredencialesSalesforceIn($SourceBank as xs:string,
    $Sesion as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_SESION>{ $Sesion }</ns0:PV_SESION>
            <ns0:PV_CODIGOPAIS>{ $SourceBank }</ns0:PV_CODIGOPAIS>
        </ns0:InputParameters>
};

declare variable $SourceBank as xs:string external;
declare variable $Sesion as xs:string external;

xf:actualizaCredencialesSalesforceIn($SourceBank,
    $Sesion)