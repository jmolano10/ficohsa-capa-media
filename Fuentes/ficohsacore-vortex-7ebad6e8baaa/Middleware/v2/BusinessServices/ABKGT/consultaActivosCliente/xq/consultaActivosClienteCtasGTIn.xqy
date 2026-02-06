xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$inputParameters1" element="ns0:InputParameters" location="../xsd/consultaActivosCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../consultaListaCuentas/xsd/consultaListaCuentas_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaActivosCliente";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaCuentas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaActivosCliente/xq/consultaListaCuentas/consultaActivosClienteIn/";

declare function xf:consultaActivosClienteIn($inputParameters1 as element(ns0:InputParameters))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CUSTOMER_ID>{ data($inputParameters1/ns0:PV_CUSTOMER_ID) }</ns1:PV_CUSTOMER_ID>
            <ns1:PV_ASSET_TYPE>CTA</ns1:PV_ASSET_TYPE>
        </ns1:InputParameters>
};

declare variable $inputParameters1 as element(ns0:InputParameters) external;

xf:consultaActivosClienteIn($inputParameters1)