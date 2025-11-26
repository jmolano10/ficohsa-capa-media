(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/CNV/reimpresionRecibo/xsd/reimpresionRecibo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:reimpresionReciboResponse" location="../xsd/reimpresionReciboTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/reimpresionRecibo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reimpresionReciboTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReimpresionRecibo/xq/ReimpresionReciboHeaderOut/";

declare function xf:ReimpresionReciboHeaderOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:reimpresionReciboResponse) {
    	if (fn:string($outputParameters1/ns0:PV_CODIGOERROR/text()) = "SUCCESS") then (
	        <ns1:reimpresionReciboResponse>
	            <CONTRACT_ID>{ data($outputParameters1/ns0:PV_CODIGOCONVENIO) }</CONTRACT_ID>
	            <DEBTOR_CODE>{ data($outputParameters1/ns0:PV_CODIGODEUDOR) }</DEBTOR_CODE>
	            <TRANSACTION_DATE>{ data($outputParameters1/ns0:PD_FECHAVALIDA) }</TRANSACTION_DATE>
	            <DEALSLIP>{ data($outputParameters1/ns0:PV_RECIBO) }</DEALSLIP>
	        </ns1:reimpresionReciboResponse>
	    ) else (
	    	<ns1:reimpresionReciboResponse/>
	    )
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:ReimpresionReciboHeaderOut($outputParameters1)