xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/pagoFicoRemesa/xsd/pagoFicoRemesas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/pagoFRemHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pagoFicoRemesas";

declare function xf:pagoFRemHeaderOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>        	
        	{
		    	if (fn:string($outputParameters1/ns0:PERR_COD/text()) != "0") then (
					<transactionId/>
				) else (
					<transactionId>{substring-after(fn:string($outputParameters1/ns0:PERR_MSJ),'#')}</transactionId>
				)
			}
            <successIndicator>
            {
		    	if (fn:string($outputParameters1/ns0:PERR_COD/text()) != "0") then (
					"ERROR"
				) else (
					"SUCCESS"
				)
			}
            </successIndicator>
            {
                for $PV_ERROR in $outputParameters1/ns0:PERR_MSJ
                return
                    <messages>{ substring-before(fn:string($PV_ERROR),'#') }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:pagoFRemHeaderOut($outputParameters1)