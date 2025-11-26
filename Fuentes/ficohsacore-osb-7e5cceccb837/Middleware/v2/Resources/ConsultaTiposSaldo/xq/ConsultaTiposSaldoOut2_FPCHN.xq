(:: pragma bea:global-element-parameter parameter="$consultaTiposSaldoRequest1" element="ns0:consultaTiposSaldoRequest" location="../xsd/consultaTiposSaldo.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/FPC/listadoInversiones/xsd/listadoInversionesFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTiposSaldoResponse" location="../xsd/consultaTiposSaldo.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoInversionesFPC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTiposSaldoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposSaldo/xq/ConsultaTiposSaldoOut2_FPCHN/";

declare function xf:ConsultaTiposSaldoOut2_FPCHN($consultaTiposSaldoRequest1 as element(ns0:consultaTiposSaldoRequest),
    $outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaTiposSaldoResponse) {
        <ns0:consultaTiposSaldoResponse>
            <ns0:PRODUCT_CODE>{ data($consultaTiposSaldoRequest1/ns0:PRODUCT_CODE) }</ns0:PRODUCT_CODE>
            <ns0:SUB_PRODUCT_LIST>
                <ns0:SUB_PRODUCT_ITEM>
                    <ns0:SUB_PRODUCT_CODE>{ data($consultaTiposSaldoRequest1/ns0:SUB_PRODUCT_CODE) }</ns0:SUB_PRODUCT_CODE>
                    <ns0:BALANCE_LIST>
                        <ns0:BALANCE_ITEM>
                            <ns0:BALANCE_CODE>{ data($consultaTiposSaldoRequest1/ns0:BALANCE_CODE) }</ns0:BALANCE_CODE>
                            <ns0:INVESTMENT_LIST>
                                {
                                    for $T_INVERSIONES_ITEM in $outputParameters1/ns1:T_INVERSIONES/ns1:T_INVERSIONES_ITEM
                                    return
                                        <ns0:INVESTMENT_ITEM>
                                            <ns0:INVESTMENT_CODE>{ data($T_INVERSIONES_ITEM/ns1:COD_INVERSION) }</ns0:INVESTMENT_CODE>
                                            <ns0:INVESTMENT_DESCRIPTION>{ data($T_INVERSIONES_ITEM/ns1:DESCRIPCION) }</ns0:INVESTMENT_DESCRIPTION>
                                        </ns0:INVESTMENT_ITEM>
                                }
                            </ns0:INVESTMENT_LIST>
                        </ns0:BALANCE_ITEM>
                    </ns0:BALANCE_LIST>
                </ns0:SUB_PRODUCT_ITEM>
            </ns0:SUB_PRODUCT_LIST>
        </ns0:consultaTiposSaldoResponse>
};

declare variable $consultaTiposSaldoRequest1 as element(ns0:consultaTiposSaldoRequest) external;
declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:ConsultaTiposSaldoOut2_FPCHN($consultaTiposSaldoRequest1,
    $outputParameters1)