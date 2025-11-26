(:: pragma bea:global-element-parameter parameter="$emisiondechqdegerenciaTTResponse1" element="ns1:EmisiondechqdegerenciaTTResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../xsds/RegistrarLiqFondosExt/registrarLiqFondosExt_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarLiqFondosExt";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/LiquidacionFondosExt/emisionChequeHeaderOut/";

declare function xf:emisionChequeHeaderOut($emisiondechqdegerenciaTTResponse1 as element(ns1:EmisiondechqdegerenciaTTResponse),
    $outputParameters1 as element(ns0:OutputParameters))
    as element(ns2:ResponseHeader) {
      if (fn:string($emisiondechqdegerenciaTTResponse1/Status/successIndicator/text()) = "Success" and
    		fn:string($outputParameters1/ns0:PN_ERROR/text()) = "0") then (
        <ns2:ResponseHeader>
            {
                for $transactionId in $emisiondechqdegerenciaTTResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $emisiondechqdegerenciaTTResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $DEBITVALUEDATE in $emisiondechqdegerenciaTTResponse1/FUNDSTRANSFERType/DEBITVALUEDATE
                return
                    <valueDate>{ data($DEBITVALUEDATE) }</valueDate>
            }
        </ns2:ResponseHeader>
        ) else (
	    	<ns0:ResponseHeader>
	            <successIndicator>ERROR</successIndicator>
	            <messages>{ fn:string-join($emisiondechqdegerenciaTTResponse1/Status/messages,";") }</messages>
	        </ns0:ResponseHeader>
	    )
};

declare variable $emisiondechqdegerenciaTTResponse1 as element(ns1:EmisiondechqdegerenciaTTResponse) external;
declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:emisionChequeHeaderOut($emisiondechqdegerenciaTTResponse1,
    $outputParameters1)