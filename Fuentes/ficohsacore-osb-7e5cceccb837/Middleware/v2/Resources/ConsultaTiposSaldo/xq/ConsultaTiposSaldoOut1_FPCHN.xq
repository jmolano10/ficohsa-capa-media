(:: pragma bea:global-element-parameter parameter="$consultaTiposSaldoRequest1" element="ns1:consultaTiposSaldoRequest" location="../xsd/consultaTiposSaldo.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/FPC/listadoTipoSaldos/xsd/listadoTipoSaldosFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTiposSaldoResponse" location="../xsd/consultaTiposSaldo.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTiposSaldoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoTipoSaldosFPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposSaldo/xq/ConsultaTiposSaldoOut_FPCHN/";

declare function xf:ConsultaTiposSaldoOut_FPCHN($consultaTiposSaldoRequest1 as element(ns1:consultaTiposSaldoRequest),
    $outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaTiposSaldoResponse) {
        <ns1:consultaTiposSaldoResponse>
            <ns1:PRODUCT_CODE>{ data($consultaTiposSaldoRequest1/ns1:PRODUCT_CODE) }</ns1:PRODUCT_CODE>
            <ns1:SUB_PRODUCT_LIST>
                <ns1:SUB_PRODUCT_ITEM>
                    <ns1:SUB_PRODUCT_CODE>{ data($consultaTiposSaldoRequest1/ns1:SUB_PRODUCT_CODE) }</ns1:SUB_PRODUCT_CODE>
                    <ns1:BALANCE_LIST>
                        {
                            for $T_TIP_SALDOS_ITEM in $outputParameters1/ns0:T_TIP_SALDOS/ns0:T_TIP_SALDOS_ITEM
                            return
                                <ns1:BALANCE_ITEM>
                                    <ns1:BALANCE_CODE>{ data($T_TIP_SALDOS_ITEM/ns0:COD_TIP_SALDO) }</ns1:BALANCE_CODE>
                                    <ns1:BALANCE_DESCRIPTION>{ data($T_TIP_SALDOS_ITEM/ns0:DESCRIPCION) }</ns1:BALANCE_DESCRIPTION>
                                </ns1:BALANCE_ITEM>
                        }
                    </ns1:BALANCE_LIST>
                </ns1:SUB_PRODUCT_ITEM>
            </ns1:SUB_PRODUCT_LIST>
        </ns1:consultaTiposSaldoResponse>
};

declare variable $consultaTiposSaldoRequest1 as element(ns1:consultaTiposSaldoRequest) external;
declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:ConsultaTiposSaldoOut_FPCHN($consultaTiposSaldoRequest1,
    $outputParameters1)