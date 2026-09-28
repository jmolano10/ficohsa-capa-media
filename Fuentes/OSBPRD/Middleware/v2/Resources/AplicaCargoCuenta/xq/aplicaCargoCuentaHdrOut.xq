(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/aplicaCargoCuenta/xsd/AplicaCargoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/AplicaCargoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AplicaCargoCuenta/xq/aplicaCargoCuentaHdrOut/";

declare function xf:aplicaCargoCuentaHdrOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $PN_ESTADO in $outputParameters1/ns1:PN_ESTADO
                return
                    <successIndicator>{ data($PN_ESTADO) }</successIndicator>
            }
            {
                for $PV_MENSAJE in $outputParameters1/ns1:PV_MENSAJE
                return
                    <messages>{ data($PV_MENSAJE) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:aplicaCargoCuentaHdrOut($outputParameters1)