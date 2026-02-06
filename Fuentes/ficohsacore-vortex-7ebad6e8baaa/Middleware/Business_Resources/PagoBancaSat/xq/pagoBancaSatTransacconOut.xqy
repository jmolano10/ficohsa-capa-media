xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../v2/BusinessServices/ABKGT/transaccionBancaSat/xsd/TRANSACCION_BANCASAT_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/TRANSACCION_BANCASAT";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoBancaSat/xq/pagoBancaSatTransacconOut/";

declare function xf:pagoBancaSatTransacconOut($outputParameters1 as element(ns0:OutputParameters))
    as xs:integer {
        $outputParameters1/ns0:PV_CODIGO_TIPO_TRANSACCION
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:pagoBancaSatTransacconOut($outputParameters1)