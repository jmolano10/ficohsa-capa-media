(:: pragma bea:global-element-parameter parameter="$consultadedetrecaudoamdcmontosResponse" element="ns2:ConsultadedetrecaudoamdcmontosResponse" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoAMDC" element="ns0:consultaRecaudoAMDC" location="../../xsds/ConsultaRecaudoAMDC/ConsultaRecaudoAMDC.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../xsds/Recaudos/RegistrarConsultaMontosAMDC/FLINK_OSB_REG_CON_MONTOS_AMDC.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRecaudoAMDCResponse" location="../../xsds/ConsultaRecaudoAMDC/ConsultaRecaudoAMDC.xsd" ::)

declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_REG_CON_MONTOS_AMDC/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAMDCTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAMDC/ConsultaMontosAMDCOut/";

declare function xf:ConsultaMontosAMDCOut($consultadedetrecaudoamdcmontosResponse as element(ns2:ConsultadedetrecaudoamdcmontosResponse),
    $consultaRecaudoAMDC as element(ns0:consultaRecaudoAMDC),
    $outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaRecaudoAMDCResponse) {
        <ns0:consultaRecaudoAMDCResponse>
        {
        	let $successIndicator :=  fn:string($consultadedetrecaudoamdcmontosResponse/Status/successIndicator/text())
        	return
        		if($successIndicator = "Success") then (
					<CONTRACT_ID>{ fn:string($consultadedetrecaudoamdcmontosResponse/LATAMAGWSPROPAMOUNTType[1]/SERVICEID/text()) }</CONTRACT_ID>,
            		<DEBTOR_CODE>{ fn:string($consultaRecaudoAMDC/DEBTOR_CODE/text()) }</DEBTOR_CODE>,
            		<DEBTOR_NAME>{ fn:string($consultadedetrecaudoamdcmontosResponse/LATAMAGWSPROPAMOUNTType[1]/CUSTOMERNAME/text()) }</DEBTOR_NAME>,
            		<CURRENCY>{ fn:string($consultadedetrecaudoamdcmontosResponse/LATAMAGWSPROPAMOUNTType[1]/TAXAMOUNTCCY/text()) }</CURRENCY>,
            		<MONTHS_TO_PAY>{ fn:string($outputParameters/ns1:MESES_PAGAR/text()) }</MONTHS_TO_PAY>,
            		<TOTAL_AMOUNT>{ fn:string($consultadedetrecaudoamdcmontosResponse/LATAMAGWSPROPAMOUNTType[1]/TOTALTAXAMOUNT/text()) }</TOTAL_AMOUNT>
            	) else ()
        }
        </ns0:consultaRecaudoAMDCResponse>
};

declare variable $consultadedetrecaudoamdcmontosResponse as element(ns2:ConsultadedetrecaudoamdcmontosResponse) external;
declare variable $consultaRecaudoAMDC as element(ns0:consultaRecaudoAMDC) external;
declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:ConsultaMontosAMDCOut($consultadedetrecaudoamdcmontosResponse,
    $consultaRecaudoAMDC,
    $outputParameters)