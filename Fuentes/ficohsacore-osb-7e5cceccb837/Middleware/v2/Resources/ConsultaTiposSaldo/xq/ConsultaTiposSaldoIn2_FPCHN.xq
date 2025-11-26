(:: pragma bea:global-element-parameter parameter="$consultaTiposSaldoRequest1" element="ns0:consultaTiposSaldoRequest" location="../xsd/consultaTiposSaldo.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/FPC/listadoInversiones/xsd/listadoInversionesFPC_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoInversionesFPC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTiposSaldoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposSaldo/xq/ConsultaTiposSaldoIn2_FPCHN/";

declare function xf:ConsultaTiposSaldoIn2_FPCHN($consultaTiposSaldoRequest1 as element(ns0:consultaTiposSaldoRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_COD_PRODUCTO>{ data($consultaTiposSaldoRequest1/ns0:PRODUCT_CODE) }</ns1:P_COD_PRODUCTO>
            {
                for $SUB_PRODUCT_CODE in $consultaTiposSaldoRequest1/ns0:SUB_PRODUCT_CODE
                return
                    <ns1:P_COD_SUBPRODUCTO>{ data($SUB_PRODUCT_CODE) }</ns1:P_COD_SUBPRODUCTO>
            }
            {
                for $BALANCE_CODE in $consultaTiposSaldoRequest1/ns0:BALANCE_CODE
                return
                    <ns1:P_COD_TIP_SALDOS>{ data($BALANCE_CODE) }</ns1:P_COD_TIP_SALDOS>
            }
        </ns1:InputParameters>
};

declare variable $consultaTiposSaldoRequest1 as element(ns0:consultaTiposSaldoRequest) external;

xf:ConsultaTiposSaldoIn2_FPCHN($consultaTiposSaldoRequest1)