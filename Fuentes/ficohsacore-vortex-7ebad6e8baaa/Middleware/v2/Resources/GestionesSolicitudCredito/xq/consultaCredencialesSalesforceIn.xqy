xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/consultaCredencialesSalesforce/xsd/consultaCredencialesSalesforce_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCredencialesSalesforce";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionesSolicitudCredito/xq/consultaCredencialesSalesforceIn/";

declare function xf:consultaCredencialesSalesforceIn($codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGOPAIS>{ $codigoPais }</ns0:PV_CODIGOPAIS>
        </ns0:InputParameters>
};

declare variable $codigoPais as xs:string external;

xf:consultaCredencialesSalesforceIn($codigoPais)