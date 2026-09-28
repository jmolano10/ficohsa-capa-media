xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$compraderecargacondbctaResponse" element="ns0:CompraderecargacondbctaResponse" location="../../../../Business_Resources/recargas/Resources/XMLSchema_-1499734640.xsd" ::)
(:: pragma bea:global-element-return element="ns1:compraRecargaResponse" location="../xsd/compraRecargaTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompraRecarga/xq/compraRecargaHNOut/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/compraRecargaTypes";

declare function if-absent 
  ( $arg as item()* ,
    $value as item()* )  as item()* {
       
    if (exists($arg))
    then $arg
    else $value
 } ;
declare function replace-multi 
  ( $arg as xs:string? ,
    $changeFrom as xs:string* ,
    $changeTo as xs:string* )  as xs:string? {
       
   if (count($changeFrom) > 0)
   then replace-multi(
          replace($arg, $changeFrom[1],
                     if-absent($changeTo[1],'')),
          $changeFrom[position() > 1],
          $changeTo[position() > 1])
   else $arg
 } ;

declare function xf:compraRecargaHNOut($compraderecargacondbctaResponse as element(ns0:CompraderecargacondbctaResponse),
    $branchName as xs:string)
    as element(ns1:compraRecargaResponse) {
        <ns1:compraRecargaResponse>
            {
                let $result :=
                    for $LRTAXPAYNAME in $compraderecargacondbctaResponse/FUNDSTRANSFERType/gLR.TAX.PAY.NAME/LRTAXPAYNAME
                    return
                        <DEBTOR_NAME>{ data($LRTAXPAYNAME) }</DEBTOR_NAME>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $INPUTTER in $compraderecargacondbctaResponse/FUNDSTRANSFERType/gINPUTTER/INPUTTER
                    return
                        <INPUTTER>{ fn:tokenize(data($INPUTTER), "_"),2 }</INPUTTER>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATETIME in $compraderecargacondbctaResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ concat("20",$DATETIME) }</DATE_TIME>
                return
                    $result[1]
            }
            <BRANCH_NAME>{ $branchName }</BRANCH_NAME>
            {
                let $FUNDSTRANSFERType := $compraderecargacondbctaResponse/FUNDSTRANSFERType
                return
	            <PAYMENT_INFORMATION>
	                <PAYMENT_METHOD>ACCT_DEBIT</PAYMENT_METHOD>
	                {
	                    for $DEBITCURRENCY in $compraderecargacondbctaResponse/FUNDSTRANSFERType/DEBITCURRENCY
	                    return
	                        <PAYMENT_CURRENCY>{ data($DEBITCURRENCY) }</PAYMENT_CURRENCY>
	                }
	                {
	                    for $DEBITAMOUNT in $compraderecargacondbctaResponse/FUNDSTRANSFERType/DEBITAMOUNT
	                    return
	                        <PAYMENT_AMOUNT>{ data($DEBITAMOUNT) }</PAYMENT_AMOUNT>
	                }
	                {
	                    for $DEBITACCTNO in $compraderecargacondbctaResponse/FUNDSTRANSFERType/DEBITACCTNO
	                    return
	                        <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
	                }
	            </PAYMENT_INFORMATION>
	            }
            	{
				for $LRBLBATCH at $i in $compraderecargacondbctaResponse/FUNDSTRANSFERType/gLR.BL.BATCH/mLR.BL.BATCH/LRBLBATCH
				return
					if($LRBLBATCH = "dealslip") then (
						<BILL_DETAIL>{ replace-multi($compraderecargacondbctaResponse/FUNDSTRANSFERType/gLR.BL.REG.NO/mLR.BL.REG.NO[$i]/LRBLREGNO, ('&amp;#61', '&amp;#44'), ('=',',')) }</BILL_DETAIL>
					) else ()
        	} 
        </ns1:compraRecargaResponse>
};

declare variable $compraderecargacondbctaResponse as element(ns0:CompraderecargacondbctaResponse) external;
declare variable $branchName as xs:string external;

xf:compraRecargaHNOut($compraderecargacondbctaResponse,
    $branchName)