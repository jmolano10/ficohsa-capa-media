xquery version "2004-draft";
(:: pragma bea:schema-type-parameter parameter="$fUNDSTRANSFERType" type="ns0:FUNDSTRANSFERType" location="../Resources/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadetallecontratorecaudoResponse" element="ns0:ConsultadetallecontratorecaudoResponse" location="../../contratosConvenios/Resources/XMLSchema_266061745.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudoResponse" location="pagoRecaudoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoReferenciadoTOut/";

(:: Equivalente a un NVL en Oracle:)
declare function if-absent 
  ( $arg as item()* ,
    $value as item()* )  as item()* {
       
    if (exists($arg))
    then $arg
    else $value
 } ;
 
(:: Realiza un replcae multiple :)
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

declare function xf:pagoRecaudoReferenciadoTOut($fUNDSTRANSFERType as element(),
    $consultadetallecontratorecaudoResponse as element(ns0:ConsultadetallecontratorecaudoResponse),
    $branchName as xs:string,
    $cuenta as xs:string)
    as element(ns1:pagoRecaudoResponse) {
        <ns1:pagoRecaudoResponse>
            {
                for $DESCRIPTION in $consultadetallecontratorecaudoResponse/WSCOLLECTIONCONDSType[1]/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType[1]/DESCRIPTION
                return
                    <CONTRACT_NAME>{ data($DESCRIPTION) }</CONTRACT_NAME>
            }
            {
                let $result :=
                    for $LRTAXPAYNAME in $fUNDSTRANSFERType/gLRTAXPAYNAME/LRTAXPAYNAME
                    return
                        <DEBTOR_NAME>{ data($LRTAXPAYNAME) }</DEBTOR_NAME>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $INPUTTER in $fUNDSTRANSFERType/gINPUTTER/INPUTTER
                    return
                        <INPUTTER>{ fn:tokenize(data($INPUTTER), "_")[2] }</INPUTTER>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATETIME in $fUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ concat("20",$DATETIME) }</DATE_TIME>
                return
                    $result[1]
            }
            <BRANCH_NAME>{ $branchName }</BRANCH_NAME>
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{ data($fUNDSTRANSFERType/LRPAYTYPE) }</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($fUNDSTRANSFERType/DEBITCURRENCY) }</PAYMENT_CURRENCY>
                {
                    for $DEBITAMOUNT in $fUNDSTRANSFERType/DEBITAMOUNT
                    return
                        <PAYMENT_AMOUNT>{ data($DEBITAMOUNT) }</PAYMENT_AMOUNT>
                }
                {
                    let $DEBITACCTNO := fn:string($cuenta)
                    return
                    	if ( $DEBITACCTNO != "") then (
                        	<DEBIT_ACCOUNT>{ $DEBITACCTNO }</DEBIT_ACCOUNT>
                        ) else ()
                }
                {
                    for $CHEQUENUMBER in $fUNDSTRANSFERType/CHEQUENUMBER
                    return
                        <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
                }
            </PAYMENT_INFORMATION>
			{
				for $LRBLBATCH at $i in $fUNDSTRANSFERType/gLRBLBATCH/mLRBLBATCH/LRBLBATCH
				return
					if($LRBLBATCH = "dealslip") then (
						<BILL_DETAIL>{ replace-multi($fUNDSTRANSFERType/gLRBLREGNO/mLRBLREGNO[$i]/LRBLREGNO, ('&amp;#61', '&amp;#44'), ('=',',')) }</BILL_DETAIL>
					) else ()
        	}               
        </ns1:pagoRecaudoResponse>
};

declare variable $fUNDSTRANSFERType as element() external;
declare variable $consultadetallecontratorecaudoResponse as element(ns0:ConsultadetallecontratorecaudoResponse) external;
declare variable $branchName as xs:string external;
declare variable $cuenta as xs:string external;

xf:pagoRecaudoReferenciadoTOut($fUNDSTRANSFERType,
    $consultadetallecontratorecaudoResponse,
    $branchName,
    $cuenta)