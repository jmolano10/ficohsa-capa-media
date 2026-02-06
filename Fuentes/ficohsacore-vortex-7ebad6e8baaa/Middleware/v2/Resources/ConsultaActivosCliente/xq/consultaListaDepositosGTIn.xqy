xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaActivosClienteRequest1" element="ns0:consultaActivosClienteRequest" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaListaDepositos/xsd/consultaListaDepositosCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaDepositosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaListaDepositos/xq/consultaListaDepositosIn/";

declare function xf:consultaListaDepositosIn($consultaActivosClienteRequest1 as element(ns0:consultaActivosClienteRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CUSTOMER_ID>{ data($consultaActivosClienteRequest1/CUSTOMER_ID) }</ns1:CUSTOMER_ID>
            <ns1:ASSET_TYPE>{ data($consultaActivosClienteRequest1/ASSET_TYPE) }</ns1:ASSET_TYPE>
        </ns1:InputParameters>
};

declare variable $consultaActivosClienteRequest1 as element(ns0:consultaActivosClienteRequest) external;

xf:consultaListaDepositosIn($consultaActivosClienteRequest1)