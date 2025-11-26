(:: pragma bea:global-element-parameter parameter="$consultaTiposSaldoRequest1" element="ns1:consultaTiposSaldoRequest" location="../xsd/consultaTiposSaldo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/FPC/listadoTipoSaldos/xsd/listadoTipoSaldosFPC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTiposSaldoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoTipoSaldosFPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposSaldo/xq/ConsultaTiposSaldosIn_FPCHN/";

declare function xf:ConsultaTiposSaldosIn_FPCHN($consultaTiposSaldoRequest1 as element(ns1:consultaTiposSaldoRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_COD_PRODUCTO>{ data($consultaTiposSaldoRequest1/ns1:PRODUCT_CODE) }</ns0:P_COD_PRODUCTO>
            {
                for $SUB_PRODUCT_CODE in $consultaTiposSaldoRequest1/ns1:SUB_PRODUCT_CODE
                return
                    <ns0:P_COD_SUBPRODUCTO>{ data($SUB_PRODUCT_CODE) }</ns0:P_COD_SUBPRODUCTO>
            }
        </ns0:InputParameters>
};

declare variable $consultaTiposSaldoRequest1 as element(ns1:consultaTiposSaldoRequest) external;

xf:ConsultaTiposSaldosIn_FPCHN($consultaTiposSaldoRequest1)