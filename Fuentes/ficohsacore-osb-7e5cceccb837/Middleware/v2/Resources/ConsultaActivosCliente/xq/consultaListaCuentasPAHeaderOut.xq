(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaListaCuentas/xsd/consultaListaCuentas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaCuentas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaListaCuentas/xq/consultaListaCuentasHeaderOut/";

declare function xf:consultaListaCuentasHeaderOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $PV_ERROR_CODE in $outputParameters1/ns1:PV_ERROR_CODE
                return
                    <successIndicator>{ data($PV_ERROR_CODE) }</successIndicator>
            }
            {
                for $PV_ERROR_MESSAGE in $outputParameters1/ns1:PV_ERROR_MESSAGE
                return
                    <messages>{ data($PV_ERROR_MESSAGE) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaListaCuentasHeaderOut($outputParameters1)