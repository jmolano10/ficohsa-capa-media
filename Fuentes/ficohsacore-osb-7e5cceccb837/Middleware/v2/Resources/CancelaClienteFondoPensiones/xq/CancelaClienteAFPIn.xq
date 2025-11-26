(:: pragma bea:global-element-parameter parameter="$cancelaClienteFondoPensionesRequest" element="ns0:cancelaClienteFondoPensionesRequest" location="../xsd/cancelaClienteFondoPensionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKHN/FondoPensiones/CancelaClienteAFP/xsd/CancelaClienteAFP_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CancelaClienteAFP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cancelaClienteFondoPensionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelaClienteFondoPensiones/xq/CancelaClienteAFPIn/";

declare function xf:CancelaClienteAFPIn($cancelaClienteFondoPensionesRequest as element(ns0:cancelaClienteFondoPensionesRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_TIPO_MONEDA>{ data($cancelaClienteFondoPensionesRequest/CURRENCY) }</ns1:PV_TIPO_MONEDA>
            <ns1:PV_CODIGO_DEUDOR>{ data($cancelaClienteFondoPensionesRequest/ID) }</ns1:PV_CODIGO_DEUDOR>
        </ns1:InputParameters>
};

declare variable $cancelaClienteFondoPensionesRequest as element(ns0:cancelaClienteFondoPensionesRequest) external;

xf:CancelaClienteAFPIn($cancelaClienteFondoPensionesRequest)
