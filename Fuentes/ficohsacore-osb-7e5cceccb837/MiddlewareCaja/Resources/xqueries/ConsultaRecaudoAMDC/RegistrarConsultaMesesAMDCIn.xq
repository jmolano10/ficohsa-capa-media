(:: pragma bea:global-element-parameter parameter="$consultaRecaudoAMDC" element="ns0:consultaRecaudoAMDC" location="../../xsds/ConsultaRecaudoAMDC/ConsultaRecaudoAMDC.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadedetrecaudoamdcmesesResponse" element="ns1:ConsultadedetrecaudoamdcmesesResponse" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../xsds/Recaudos/RegistrarConsultaMesesAMDC/FLINK_OSB_REG_CON_MESES_AMDC.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_REG_CON_MESES_AMDC/";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAMDCTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAMDC/RegistrarConsultaMesesAMDCIn/";

declare function xf:RegistrarConsultaMesesAMDCIn($consultaRecaudoAMDC as element(ns0:consultaRecaudoAMDC),
    $consultadedetrecaudoamdcmesesResponse as element(ns1:ConsultadedetrecaudoamdcmesesResponse))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:CONTRATO>{ data($consultaRecaudoAMDC/CONTRACT_ID) }</ns2:CONTRATO>
            <ns2:DEUDOR>{ data($consultaRecaudoAMDC/DEBTOR_CODE) }</ns2:DEUDOR>
            <ns2:MESES>
                {
                    for $INVOICENO in $consultadedetrecaudoamdcmesesResponse/LATAMAGWSPROPMONTHSType[1]/gLATAMAGWSPROPMONTHSDetailType/mLATAMAGWSPROPMONTHSDetailType/INVOICENO
                    return
                        <ns2:ITEM>{ data($INVOICENO) }</ns2:ITEM>
                }
            </ns2:MESES>
            <ns2:FECHAS>
                {
                    for $DUEDATE in $consultadedetrecaudoamdcmesesResponse/LATAMAGWSPROPMONTHSType[1]/gLATAMAGWSPROPMONTHSDetailType/mLATAMAGWSPROPMONTHSDetailType/DUEDATE
                    return
                        <ns2:ITEM>{ data($DUEDATE) }</ns2:ITEM>
                }
            </ns2:FECHAS>
        </ns2:InputParameters>
};

declare variable $consultaRecaudoAMDC as element(ns0:consultaRecaudoAMDC) external;
declare variable $consultadedetrecaudoamdcmesesResponse as element(ns1:ConsultadedetrecaudoamdcmesesResponse) external;

xf:RegistrarConsultaMesesAMDCIn($consultaRecaudoAMDC,
    $consultadedetrecaudoamdcmesesResponse)