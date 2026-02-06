xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$inputParameters1" element="ns0:InputParameters" location="../xsd/consultaActivosCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../consultaListaDepositos/xsd/consultaListaDepositosCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaActivosCliente";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaDepositosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaActivosCliente/xq/consultaListaDepositos/consultaActivosClienteIn/";

declare function xf:consultaActivosClienteIn($inputParameters1 as element(ns0:InputParameters))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $PV_CUSTOMER_ID in $inputParameters1/ns0:PV_CUSTOMER_ID
                return
                    <ns1:CUSTOMER_ID>{ data($PV_CUSTOMER_ID) }</ns1:CUSTOMER_ID>
            }
            <ns1:ASSET_TYPE>DEP</ns1:ASSET_TYPE>
        </ns1:InputParameters>
};

declare variable $inputParameters1 as element(ns0:InputParameters) external;

xf:consultaActivosClienteIn($inputParameters1)