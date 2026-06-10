<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transacciondesubastaResponse" element="ns0:TransacciondesubastaResponse" location="../Resources/XMLSchema_-1390898219.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transaccionSubastaResponse" location="transaccionSubastaTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transaccionSubasta" element="ns1:transaccionSubasta" location="transaccionSubastaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transaccionSubastaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/subasta/transaccionSubasta/transaccionSubastaOut/";

declare function xf:transaccionSubastaOut($transacciondesubastaResponse as element(ns0:TransacciondesubastaResponse),
	$transaccionSubasta as element(ns1:transaccionSubasta))
    as element(ns1:transaccionSubastaResponse) {
        <ns1:transaccionSubastaResponse>
            <DEBIT_ACCOUNT>{ data($transacciondesubastaResponse/FUNDSTRANSFERType/DEBITACCTNO) }</DEBIT_ACCOUNT>
           
{
                	let $TRANSACTION_TYPE := fn:string($transaccionSubasta/TRANSACTION_TYPE/text())
                	return
                		if($TRANSACTION_TYPE = "ACCTTRF") then (
                			<AMOUNT_DEBITED>{ data($transacciondesubastaResponse/FUNDSTRANSFERType/DEBITAMOUNT) }</AMOUNT_DEBITED>
                			
                		) else if($TRANSACTION_TYPE = "INTLTRF") then (
                            <AMOUNT_DEBITED>{ data($transacciondesubastaResponse/FUNDSTRANSFERType/DEBITAMOUNT) }</AMOUNT_DEBITED>                			
                		) else if($TRANSACTION_TYPE = "CASHCHQ") then (
                			<AMOUNT_DEBITED></AMOUNT_DEBITED>
                			
                		) else ()
                }           
        </ns1:transaccionSubastaResponse>
};

declare variable $transacciondesubastaResponse as element(ns0:TransacciondesubastaResponse) external;
declare variable $transaccionSubasta as element(ns1:transaccionSubasta) external;

xf:transaccionSubastaOut($transacciondesubastaResponse,
	$transaccionSubasta)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_-1390898219.xsd">
        <con:schema ref="Middleware/Business_Resources/subasta/Resources/XMLSchema_-1390898219"/>
    </con:dependency>
    <con:dependency location="transaccionSubastaTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/subasta/transaccionSubasta/transaccionSubastaTypes"/>
    </con:dependency>
</con:xqueryEntry>