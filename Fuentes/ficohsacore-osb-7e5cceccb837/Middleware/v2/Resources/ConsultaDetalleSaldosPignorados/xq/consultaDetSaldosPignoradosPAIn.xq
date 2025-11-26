(:: pragma bea:global-element-parameter parameter="$consultaDetalleSaldosPignorados1" element="ns1:consultaDetalleSaldosPignorados" location="../xsd/consultaDetalleSaldosPignoradosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaDetalleSaldosPignorados/xsd/consultaDetalleSaldosPignorados_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleSaldosPignorados";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleSaldosPignoradosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaDetalleSaldosPignorados/xq/consultaDetalleSaldosPignoradosIn/";

declare function xf:consultaDetalleSaldosPignoradosIn($consultaDetalleSaldosPignorados1 as element(ns1:consultaDetalleSaldosPignorados))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:ACCOUNT_NUMBER>{ data($consultaDetalleSaldosPignorados1/ACCOUNT_NUMBER) }</ns0:ACCOUNT_NUMBER>
        </ns0:InputParameters>
};

declare variable $consultaDetalleSaldosPignorados1 as element(ns1:consultaDetalleSaldosPignorados) external;

xf:consultaDetalleSaldosPignoradosIn($consultaDetalleSaldosPignorados1)