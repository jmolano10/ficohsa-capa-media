(:: pragma bea:global-element-parameter parameter="$consultaRecaudoAMDCResponse" element="ns0:consultaRecaudoAMDCResponse" location="../../xsds/ConsultaRecaudoAMDC/ConsultaRecaudoAMDC.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/Recaudos/RegistrarNombreDeudorAMDC/FLINK_OSB_REG_NOMBRE_DEUDOR_AMDC.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_REG_NOMBRE_DEUDOR_AMDC/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAMDCTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAMDC/RegistrarNombreDeudorAMDCIn/";

declare function xf:RegistrarNombreDeudorAMDCIn($consultaRecaudoAMDCResponse as element(ns0:consultaRecaudoAMDCResponse))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $CONTRACT_ID in $consultaRecaudoAMDCResponse/CONTRACT_ID
                return
                    <ns1:CONTRATO>{ data($CONTRACT_ID) }</ns1:CONTRATO>
            }
            {
                for $DEBTOR_CODE in $consultaRecaudoAMDCResponse/DEBTOR_CODE
                return
                    <ns1:DEUDOR>{ data($DEBTOR_CODE) }</ns1:DEUDOR>
            }
            {
                for $DEBTOR_NAME in $consultaRecaudoAMDCResponse/DEBTOR_NAME
                return
                    <ns1:NOMB_DEUDOR>{ data($DEBTOR_NAME) }</ns1:NOMB_DEUDOR>
            }
        </ns1:InputParameters>
};

declare variable $consultaRecaudoAMDCResponse as element(ns0:consultaRecaudoAMDCResponse) external;

xf:RegistrarNombreDeudorAMDCIn($consultaRecaudoAMDCResponse)