(:: pragma bea:global-element-parameter parameter="$consultaRecaudoAMDC" element="ns0:consultaRecaudoAMDC" location="../../xsds/ConsultaRecaudoAMDC/ConsultaRecaudoAMDC.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/Recaudos/RegistrarConsultaMontosAMDC/FLINK_OSB_REG_CON_MONTOS_AMDC.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_REG_CON_MONTOS_AMDC/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAMDCTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAMDC/RegistrarConsultaMontosAMDCIn/";

declare function xf:RegistrarConsultaMontosAMDCIn($consultaRecaudoAMDC as element(ns0:consultaRecaudoAMDC))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CONTRATO>{ data($consultaRecaudoAMDC/CONTRACT_ID) }</ns1:CONTRATO>
            <ns1:DEUDOR>{ data($consultaRecaudoAMDC/DEBTOR_CODE) }</ns1:DEUDOR>
            {
                for $MONTHS_TO_PAY in $consultaRecaudoAMDC/MONTHS_TO_PAY
                return
                    <ns1:NRO_MESES_CONS>{ data($MONTHS_TO_PAY) }</ns1:NRO_MESES_CONS>
            }
        </ns1:InputParameters>
};

declare variable $consultaRecaudoAMDC as element(ns0:consultaRecaudoAMDC) external;

xf:RegistrarConsultaMontosAMDCIn($consultaRecaudoAMDC)