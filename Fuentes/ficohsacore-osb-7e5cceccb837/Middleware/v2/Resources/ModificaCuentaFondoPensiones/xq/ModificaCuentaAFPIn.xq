(:: pragma bea:global-element-parameter parameter="$modificaCuentaFondoPensionesRequest" element="ns0:modificaCuentaFondoPensionesRequest" location="../xsd/modificaCuentaFondoPensionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKHN/FondoPensiones/ModificaCuentaAFP/xsd/ModificaCuentaAFP_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ModificaCuentaAFP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/modificaCuentaFondoPensionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaCuentaFondoPensiones/xq/ModificaCuentaAFPIn/";

declare function xf:ModificaCuentaAFPIn($modificaCuentaFondoPensionesRequest as element(ns0:modificaCuentaFondoPensionesRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGO_DEUDOR>{ data($modificaCuentaFondoPensionesRequest/ID) }</ns1:PV_CODIGO_DEUDOR>
            <ns1:PV_CUENTA_AHORRO>{ data($modificaCuentaFondoPensionesRequest/ACCOUNT) }</ns1:PV_CUENTA_AHORRO>
        </ns1:InputParameters>
};

declare variable $modificaCuentaFondoPensionesRequest as element(ns0:modificaCuentaFondoPensionesRequest) external;

xf:ModificaCuentaAFPIn($modificaCuentaFondoPensionesRequest)
