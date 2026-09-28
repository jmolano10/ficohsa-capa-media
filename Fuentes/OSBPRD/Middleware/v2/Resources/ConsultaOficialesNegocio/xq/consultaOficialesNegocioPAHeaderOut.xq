(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaOficialesNegocio/xsd/consultaOficialesNegocio_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOficialesNegocio";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOficialesNegocio/xq/consultaOficialesNegocioPAHeaderOut/";

declare function xf:consultaOficialesNegocioPAHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $PV_ERROR_CODE in $outputParameters/ns1:PV_ERROR_CODE
                return
                    <successIndicator>{ data($PV_ERROR_CODE) }</successIndicator>
            }
            {
                for $PV_ERROR_MESSAGE in $outputParameters/ns1:PV_ERROR_MESSAGE
                return
                    <messages>{ data($PV_ERROR_MESSAGE) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaOficialesNegocioPAHeaderOut($outputParameters)