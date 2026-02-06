xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../../Business_Resources/ConsultasCuenta/Resources/ConsultaMovimientosCuenta/xsd/ORA_BANK_OSB_K_CONSULTAMOVSCUENTA_TOPLEVEL-24OSB_CON_MOVS_CTA.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuenta1" element="ns0:consultaMovimientosCuenta" location="../xsd/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMovimientosCuentaResponse" location="../xsd/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTAMOVSCUENTA/TOPLEVEL-24OSB_CON_MOVS_CTA/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuenta/xq/ConsultaMovimientosCuentaAbanksOut/";

declare function xf:ConsultaMovimientosCuentaAbanksOut($outputParameters1 as element(ns1:OutputParameters),
    $consultaMovimientosCuenta1 as element(ns0:consultaMovimientosCuenta),
    $ticket as xs:string)
    as element(ns0:consultaMovimientosCuentaResponse) {
        <ns0:consultaMovimientosCuentaResponse>
            {
                for $ACCOUNT_NUMBER_OUT in $outputParameters1/ns1:ACCOUNT_NUMBER_OUT
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER_OUT) }</ACCOUNT_NUMBER>
            }
            {
                for $ACCOUNT_NAME in $outputParameters1/ns1:ACCOUNT_NAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNT_NAME) }</ACCOUNT_NAME>
            }
            {
                for $CURRENCY in $outputParameters1/ns1:CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $STARTING_BALANCE in $outputParameters1/ns1:STARTING_BALANCE
                return
                    <STARTING_BALANCE>{ data($STARTING_BALANCE) }</STARTING_BALANCE>
            }
            {
                for $ENDING_BALANCE in $outputParameters1/ns1:ENDING_BALANCE
                return
                    <ENDING_BALANCE>{ data($ENDING_BALANCE) }</ENDING_BALANCE>
            }
            {
                for $START_DATE in $outputParameters1/ns1:START_DATE
                return
                    <START_DATE>{ data($START_DATE) }</START_DATE>
            }
            {
                for $END_DATE_OUT in $outputParameters1/ns1:END_DATE_OUT
                return
                    <END_DATE>{ data($END_DATE_OUT) }</END_DATE>
            }
            <RECORDS_INFO>
                {
                    for $INICIAL_RECORD in $consultaMovimientosCuenta1/PAGING_INFO/INITIAL_RECORD
                    return
                        <INITIAL_RECORD>{ data($INICIAL_RECORD) }</INITIAL_RECORD>
                }
                {
                    for $RECORD_COUNT in $consultaMovimientosCuenta1/PAGING_INFO/RECORD_COUNT
                    return
                        <RECORDS_RETURNED>
                        { 

                        	let $AbanksNumber := if(xs:integer(count($outputParameters1/ns1:REF_NO/ns1:ITEM)) != 0) then
                        							xs:integer(count($outputParameters1/ns1:REF_NO/ns1:ITEM))
                        						 else
                        						 	0
                        	              		 	
                        	let $refs := xs:integer(data($AbanksNumber))
                        	let $Suma := (xs:integer(data($RECORD_COUNT)) + xs:integer(data($consultaMovimientosCuenta1/PAGING_INFO/INITIAL_RECORD)))
                        	return
                        	if(xs:integer(data($Suma)) > xs:integer(data($refs))) then
                        		(xs:integer($refs) - xs:integer($consultaMovimientosCuenta1/PAGING_INFO/INITIAL_RECORD)) + 1
                        	else
                        		xs:integer(data($RECORD_COUNT))
                        
                        }
                        </RECORDS_RETURNED>
                }
                <RECORDS_TOTAL>{count($outputParameters1/ns1:REF_NO/ns1:ITEM)}</RECORDS_TOTAL>
                <TICKET>{ $ticket }</TICKET>
                              
            </RECORDS_INFO>
            
            <ns0:consultaMovimientosCuentaResponseType>
                {
                    let $vDates  := ($outputParameters1/ns1:VALUE_DATE/ns1:ITEM)  
                    let $descrs  := ($outputParameters1/ns1:DESCRIPTION/ns1:ITEM)  
                    let $refs  := ($outputParameters1/ns1:REF_NO/ns1:ITEM)  
                    let $docNros  := ($outputParameters1/ns1:DOCUMENT_NUMBER/ns1:ITEM) 
                    let $txnReference := ($outputParameters1/ns1:DEUDOR/ns1:ITEM) 
                    let $amounts  := ($outputParameters1/ns1:AMOUNT/ns1:ITEM)  
                    let $effectBal  := ($outputParameters1/ns1:EFFECT_ON_BALANCE/ns1:ITEM)  
				 	
                    let $contador := if((xs:integer(data($consultaMovimientosCuenta1/PAGING_INFO/RECORD_COUNT)) + xs:integer(count($outputParameters1/ns1:REF_NO/ns1:ITEM))) > count($refs)) then
                    					count($refs)
                    				 else
                    				 	(xs:integer(data($consultaMovimientosCuenta1/PAGING_INFO/RECORD_COUNT)) + xs:integer(count($outputParameters1/ns1:REF_NO/ns1:ITEM)))
                    				 			 	
                    let $inicio := data($consultaMovimientosCuenta1/PAGING_INFO/INITIAL_RECORD)
                    
                    
                    return
                        for $i  in ($inicio to $contador)  
                        return
                            (
                            <ns0:consultaMovimientosCuentaResponseRecordType>
	                            <VALUE_DATE>{ data($vDates[$i]) }</VALUE_DATE>
	                            <DESCRIPTION>{ data($descrs[$i]) }</DESCRIPTION>
	                            <REF_NO>{ data($refs[$i]) }</REF_NO>
	                            <DOCUMENT_NUMBER>{ data($docNros[$i]) }</DOCUMENT_NUMBER>
	                            <TXN_REFERENCE>{ data($txnReference[$i]) }</TXN_REFERENCE>
	                            <AMOUNT>{ data($amounts[$i]) }</AMOUNT>
	                            <EFFECT_ON_BALANCE>{ data($effectBal[$i]) }</EFFECT_ON_BALANCE>
	                            <INPUTTER></INPUTTER>
	                            <TXNCODE></TXNCODE>
								<TXNAGNCODE></TXNAGNCODE>
								<TXNAGNNAME></TXNAGNNAME>
								<TXNDESCRIPTIONALL></TXNDESCRIPTIONALL>
								<AUTHORISER></AUTHORISER>
								<TXNDATETIME></TXNDATETIME>
                            </ns0:consultaMovimientosCuentaResponseRecordType>
                            )
                }
			</ns0:consultaMovimientosCuentaResponseType>
			
        </ns0:consultaMovimientosCuentaResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $consultaMovimientosCuenta1 as element(ns0:consultaMovimientosCuenta) external;
declare variable $ticket as xs:string external;

xf:ConsultaMovimientosCuentaAbanksOut($outputParameters1,
    $consultaMovimientosCuenta1,
    $ticket)