xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultadereciboderecaudoResponse" element="ns0:ConsultadereciboderecaudoResponse" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaReciboRecaudoResponse" location="../../xsds/ConsultaReciboRecaudo/ConsultaReciboRecaudo.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaReciboRecaudo/ConsultaReciboRecaudoOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaReciboRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:ConsultaReciboRecaudoOut($consultadereciboderecaudoResponse as element(ns0:ConsultadereciboderecaudoResponse))
    as element(ns1:consultaReciboRecaudoResponse) {
        <ns1:consultaReciboRecaudoResponse>
        	{
        		for $registro in $consultadereciboderecaudoResponse/LATAMAGEDSLIPREPRINTWEBType[1]/gLATAMAGEDSLIPREPRINTWEBDetailType/mLATAMAGEDSLIPREPRINTWEBDetailType[TAGNAME="dealslip"][1]
            		return (
						<TRANSACTION_ID>{ data($registro/TRANSACTIONID) }</TRANSACTION_ID>,
						<SERVICE_ID>{ data($registro/SERVICEID) }</SERVICE_ID>,
						<PAYMENT_CODE>{ data($registro/PAYMENTCODE) }</PAYMENT_CODE>,
						<REMITTANCE_KEY>{ data($registro/REMITTANCEKEY) }</REMITTANCE_KEY>,
						<TRANSACTION_DATE>{ data($registro/TRANSACTIONDATE) }</TRANSACTION_DATE>,
						<DEALSLIP>{ data($registro/TAGVALUES) }</DEALSLIP>
				)
            }
        </ns1:consultaReciboRecaudoResponse>
};

declare variable $consultadereciboderecaudoResponse as element(ns0:ConsultadereciboderecaudoResponse) external;

xf:ConsultaReciboRecaudoOut($consultadereciboderecaudoResponse)