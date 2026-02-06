xquery version "2004-draft";
(:: pragma bea:schema-type-parameter parameter="$fUNDSTRANSFERType" type="ns0:FUNDSTRANSFERType" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleContratoRecaudosResponse" element="ns0:consultaDetalleContratoRecaudosResponse" location="../../../BusinessServices/OSB/ConsultaDetalleContratoRecaudo_v2/xsd/XMLSchema_-1149530574.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudoResponse" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
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
    $consultaDetalleContratoRecaudosResponse as element(ns0:consultaDetalleContratoRecaudosResponse),

    $branchName as xs:string,
    $authorizationCode as xs:string,
    $cuenta as xs:string)
    as element(ns1:pagoRecaudoResponse) {
        <ns1:pagoRecaudoResponse>
            {
                for $CONTRACT_NAME in $consultaDetalleContratoRecaudosResponse/ns0:consultaDetalleContratoRecaudosResponseType/ns0:consultaDetalleContratoRecaudosResponseRecordType[1]/CONTRACT_NAME

                return
                    <CONTRACT_NAME>{ data($CONTRACT_NAME) }</CONTRACT_NAME>
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
        	{ if($authorizationCode!='')
             then 
             <REFERENCE_ID>{$authorizationCode}</REFERENCE_ID>
             else
             <REFERENCE_ID></REFERENCE_ID>
            }              
        </ns1:pagoRecaudoResponse>
};

declare variable $fUNDSTRANSFERType as element() external;
declare variable $consultaDetalleContratoRecaudosResponse as element(ns0:consultaDetalleContratoRecaudosResponse) external;

declare variable $branchName as xs:string external;
declare variable $authorizationCode as xs:string external;
declare variable $cuenta as xs:string external;

xf:pagoRecaudoReferenciadoTOut($fUNDSTRANSFERType,
    $consultaDetalleContratoRecaudosResponse,

    $branchName,
    $authorizationCode,
    $cuenta)