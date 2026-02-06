xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaCliente/xsd/consultaCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCliente";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/abanksGT/consultaCliente/xq/consultaClienteHeaderOut/";

declare function xf:consultaClienteHeaderOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $PV_CODIGOMENSAJE in $outputParameters1/ns1:PV_CODIGOMENSAJE
                return
                    <successIndicator>{ data($PV_CODIGOMENSAJE) }</successIndicator>
            }
            {
                for $PV_DESCRIPCIONMENSAJE in $outputParameters1/ns1:PV_DESCRIPCIONMENSAJE
                return
                    <messages>{ data($PV_DESCRIPCIONMENSAJE) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaClienteHeaderOut($outputParameters1)