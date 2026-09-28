(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/PagoRemesaCreditoCuenta/xsd/pagoRemesaCreditoCuentaGT_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pagoRemesaCreditoCuentaGT";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesaCreditoCuenta/xq/PagRemCredCtaHeaderOut/";

declare function xf:PagRemCredCtaHeaderOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $PV_SECUENCIA in $outputParameters1/ns0:PV_SECUENCIA
                return
                    <transactionId>{ data($PV_SECUENCIA) }</transactionId>
            }

                    <successIndicator>SUCCESS</successIndicator>
           
            {
                for $PV_DESCRIPCIONMENSAJE in $outputParameters1/ns0:PV_DESCRIPCIONMENSAJE
                return
                    <messages>{ data($PV_DESCRIPCIONMENSAJE) }</messages>
            }
            {
                for $PV_FECHATRANSACCION in $outputParameters1/ns0:PV_FECHATRANSACCION
                return
                    <valueDate>{ data($PV_FECHATRANSACCION) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:PagRemCredCtaHeaderOut($outputParameters1)