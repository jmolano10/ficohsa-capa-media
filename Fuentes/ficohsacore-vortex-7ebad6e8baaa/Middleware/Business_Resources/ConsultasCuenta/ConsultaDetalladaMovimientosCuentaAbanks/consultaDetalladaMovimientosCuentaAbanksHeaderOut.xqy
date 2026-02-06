xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../Resources/ConsultaDetalladaMovimientosCuenta/xsd/ORA_BANK_OSB_K__CONSDETMOVSCTA_TOPLEVEL-24OSB_CON_DET_MOVS_CTA.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K__CONSDETMOVSCTA/TOPLEVEL-24OSB_CON_DET_MOVS_CTA/";
declare namespace xf = "http://tempuri.org/MiddlewareAbanks/Business_Resources/ConsultasCuenta/ConsultaDetalladaMovimientosCuenta/consultaDetalladaMovimientosCuentaHeaderOut/";

declare function xf:consultaDetalladaMovimientosCuentaHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $ERROR_CODE in $outputParameters/ns0:ERROR_CODE
                return
                    <successIndicator>{ data($ERROR_CODE) }</successIndicator>
            }
            {
                for $ERROR_MESSAGE in $outputParameters/ns0:ERROR_MESSAGE
                return
                    <messages>{ data($ERROR_MESSAGE) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaDetalladaMovimientosCuentaHeaderOut($outputParameters)