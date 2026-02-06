xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/consultaCalendarioPagoPrestamo/xsd/consultaCalendarioPagoPrestamo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCalendarioPagoPrestamoResponse" location="../../../../Business_Resources/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamoTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCalendarioPagoPrestamo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCalendarioPagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaCalendarioPagoPrestamo/xq/consultaCalendarioPrestamoOut/";

declare function xf:consultaCalendarioPrestamoOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaCalendarioPagoPrestamoResponse) {
        <ns1:consultaCalendarioPagoPrestamoResponse>
            <ns1:consultaCalendarioPagoPrestamoResponseType>
                {
                
                	let $billReference := $outputParameters1/ns0:BILL_REFERENCE/ns0:BILL_REFERENCE_ITEM
                	let $billNumber := $outputParameters1/ns0:BILL_NUMBER/ns0:BILL_REFERENCE_ITEM
                	let $billDate := $outputParameters1/ns0:BILL_DATE/ns0:BILL_REFERENCE_ITEM
                	let $description := $outputParameters1/ns0:DESCRIPTION/ns0:DESCRIPTION_ITEM
                	let $principalAmount := $outputParameters1/ns0:PRINCIPAL_AMOUNT/ns0:BILL_REFERENCE_ITEM0
                	let $interestAmount := $outputParameters1/ns0:INTEREST_AMOUNT/ns0:BILL_REFERENCE_ITEM
                	let $overdueAmount := $outputParameters1/ns0:OVERDUE_AMOUNT/ns0:BILL_REFERENCE_ITEM
                	let $otherAmount := $outputParameters1/ns0:OTHER_AMOUNT/ns0:BILL_REFERENCE_ITEM
                	let $billTotalAmount := $outputParameters1/ns0:BILL_TOTAL_AMOUNT/ns0:BILL_REFERENCE_ITEM
                	let $billOutstandingAmount :=  $outputParameters1/ns0:BILL_OUTSTANDING_AMOUNT/ns0:BILL_REFERENCE_ITEM
                	let $billStatus := $outputParameters1/ns0:BILL_STATUS/ns0:BILL_STATUS_ITEM
                	
                    for $i in (1 to count($billReference))
                    return
                        <ns1:consultaCalendarioPagoPrestamoResponseRecordType>
                            <BILL_REFERENCE>{ data($billReference[$i]) }</BILL_REFERENCE>
                            <BILL_NUMBER>{ data($billNumber[$i]) }</BILL_NUMBER>
                            <BILL_DATE>{ data($billDate[$i]) }</BILL_DATE>
                            <DESCRIPTION>{ data($description[$i]) }</DESCRIPTION>
                            <PRINCIPAL_AMOUNT>{ data($principalAmount[$i]) }</PRINCIPAL_AMOUNT>
                            <INTEREST_AMOUNT>{ data($interestAmount[$i]) }</INTEREST_AMOUNT>
                            <OVERDUE_AMOUNT>{ data($overdueAmount[$i]) }</OVERDUE_AMOUNT>
                            <OTHER_AMOUNT>{ data($otherAmount[$i]) }</OTHER_AMOUNT>
                            <BILL_TOTAL_AMOUNT>{ data($billTotalAmount[$i]) }</BILL_TOTAL_AMOUNT>
                            <BILL_OUTSTANDING_AMOUNT>{ data($billOutstandingAmount[$i]) }</BILL_OUTSTANDING_AMOUNT>
                            <BILL_STATUS>{ data($billStatus[$i]) }</BILL_STATUS>
                        </ns1:consultaCalendarioPagoPrestamoResponseRecordType>
                }
            </ns1:consultaCalendarioPagoPrestamoResponseType>
        </ns1:consultaCalendarioPagoPrestamoResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaCalendarioPrestamoOut($outputParameters1)