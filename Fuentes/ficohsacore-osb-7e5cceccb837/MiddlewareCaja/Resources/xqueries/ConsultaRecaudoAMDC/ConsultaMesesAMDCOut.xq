(:: pragma bea:global-element-parameter parameter="$consultaRecaudoAMDC" element="ns0:consultaRecaudoAMDC" location="../../xsds/ConsultaRecaudoAMDC/ConsultaRecaudoAMDC.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../xsds/Recaudos/RegistrarConsultaMesesAMDC/FLINK_OSB_REG_CON_MESES_AMDC.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadedetrecaudoamdcmesesResponse" element="ns1:ConsultadedetrecaudoamdcmesesResponse" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRecaudoAMDCResponse" location="../../xsds/ConsultaRecaudoAMDC/ConsultaRecaudoAMDC.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_REG_CON_MESES_AMDC/";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAMDCTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAMDC/ConsultaMesesAMDCOut/";

declare function xf:ConsultaMesesAMDCOut($consultaRecaudoAMDC as element(ns0:consultaRecaudoAMDC),
    $outputParameters as element(ns2:OutputParameters),
    $consultadedetrecaudoamdcmesesResponse as element(ns1:ConsultadedetrecaudoamdcmesesResponse))
    as element(ns0:consultaRecaudoAMDCResponse) {
        <ns0:consultaRecaudoAMDCResponse>
        {
        	let $successIndicator := fn:string($consultadedetrecaudoamdcmesesResponse/Status/successIndicator/text())
        	return
        		if($successIndicator = "Success") then (
		            <CONTRACT_ID>{ data($consultaRecaudoAMDC/CONTRACT_ID) }</CONTRACT_ID>,
		            <DEBTOR_CODE>{ data($consultaRecaudoAMDC/DEBTOR_CODE) }</DEBTOR_CODE>,
		            <MONTHS_TO_PAY>{ data($outputParameters/ns2:MESES_ADEUDADOS) }</MONTHS_TO_PAY>
            ) else ()
        }
        </ns0:consultaRecaudoAMDCResponse>
};

declare variable $consultaRecaudoAMDC as element(ns0:consultaRecaudoAMDC) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;
declare variable $consultadedetrecaudoamdcmesesResponse as element(ns1:ConsultadedetrecaudoamdcmesesResponse) external;

xf:ConsultaMesesAMDCOut($consultaRecaudoAMDC,
    $outputParameters,
    $consultadedetrecaudoamdcmesesResponse)