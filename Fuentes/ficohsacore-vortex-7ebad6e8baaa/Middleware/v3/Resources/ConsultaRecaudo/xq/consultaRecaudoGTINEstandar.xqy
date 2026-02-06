xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo1" element="ns0:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/ConsultaRecaudo/xsd/ConsultaRecaudo_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRecaudo";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaRecaudo/xq/consultaRecaudoGTIN/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getFecha ($Fecha as xs:string)  as xs:dateTime { 
	if( string-length($Fecha)=19)then(	  
         fn-bea:dateTime-from-string-with-format("dd/MM/yyyy hh:mm:ss", data($Fecha) ))
	else(
	     fn-bea:dateTime-from-string-with-format("M/dd/yyyy hh:mm:ss a", data($Fecha) ))
 };

declare function xf:ConsultaRecaudoGTIn($consultaRecaudo1 as element(ns0:consultaRecaudo),
    $Contrato as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CONTRACT_ID>{ $Contrato }</ns1:PV_CONTRACT_ID>
            <ns1:PV_DEBTOR_CODE>{ data($consultaRecaudo1/DEBTOR_CODE) }</ns1:PV_DEBTOR_CODE>
            <ns1:PV_CURRENCY>{ data($consultaRecaudo1/CURRENCY) }</ns1:PV_CURRENCY>
            {
                for $BILL_AMOUNT in $consultaRecaudo1/BILL_AMOUNT
                return
                    <ns1:PV_BILL_AMOUNT>{ data($BILL_AMOUNT) }</ns1:PV_BILL_AMOUNT>
            }
            {
            	if($Contrato = '182' or $Contrato = '198') then (
            		let $result :=
            			for $ADDITIONAL_INFO in $consultaRecaudo1/ADDITIONAL_INFO
                		return
                        	for $DATA in $ADDITIONAL_INFO/DATA
                			return
	                          	for $DATA in $ADDITIONAL_INFO/DATA
                			return
	          	         
	                    	data($DATA)
                     let $BillDate :=(getFecha($result[2]) )
                    return
                    	<ns1:PV_BILL_DATE>{ fn-bea:dateTime-to-string-with-format("dd/MM/yyyy", data($BillDate)) }</ns1:PV_BILL_DATE>
						
            	) else (
                	for $BILL_DATE in $consultaRecaudo1/BILL_DATE
                	return
	                    <ns1:PV_BILL_DATE>{ data($BILL_DATE) }</ns1:PV_BILL_DATE>
                )
            }
            {
                for $BILL_RETURN_TYPE in $consultaRecaudo1/BILL_RETURN_TYPE
                return
                    <ns1:PV_BILL_RETURN_TYPE>{ data($BILL_RETURN_TYPE) }</ns1:PV_BILL_RETURN_TYPE>
            }
            {
                for $EXTENDED_COLLECTION_YES_NO in $consultaRecaudo1/EXTENDED_COLLECTION_YES_NO
                return
                    <ns1:PV_EXTENDED_COLLECTION_Y_N>{ data($EXTENDED_COLLECTION_YES_NO) }</ns1:PV_EXTENDED_COLLECTION_Y_N>
            }
            {
                for $ADDITIONAL_INFO in $consultaRecaudo1/ADDITIONAL_INFO
                return
                    <ns1:PV_DATA>
                        {
                            for $DATA in $ADDITIONAL_INFO/DATA
                            return
                                <ns1:PV_DATA_ITEM>{ data($DATA) }</ns1:PV_DATA_ITEM>
                        }
                    </ns1:PV_DATA>
            }
        </ns1:InputParameters>
};

declare variable $consultaRecaudo1 as element(ns0:consultaRecaudo) external;
declare variable $Contrato as xs:string external;

xf:ConsultaRecaudoGTIn($consultaRecaudo1,
    $Contrato)