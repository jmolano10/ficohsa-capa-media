xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKHN/RegistraParametrizacion/xsd/registraParametrizacion_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraParametrizacion";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraParametrizacion/xq/registraParametrizacionOut/";

declare function xf:registraParametrizacionOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $PV_MENSAJE_ERROR in $outputParameters/ns1:PV_MENSAJE_ERROR
                return
                    <messageId>{ data($PV_MENSAJE_ERROR) }</messageId>
            }
            {
                for $PV_CODIGO_ERROR in $outputParameters/ns1:PV_CODIGO_ERROR
                return
                    <successIndicator>{ data($PV_CODIGO_ERROR) }</successIndicator>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:registraParametrizacionOut($outputParameters)