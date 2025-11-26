xquery version "1.0" encoding "Cp1252";
(:: pragma bea:schema-type-parameter parameter="$fUNDSTRANSFERType" type="ns0:FUNDSTRANSFERType" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/ABK/pagoRecaudoAbanks/xsd/pagoRecaudoAbanks_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeparametroscoreResponse" element="ns0:ConsultadeparametroscoreResponse" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudoResponse" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoRecaudoPagoAbanksFTOut/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pagoRecaudoAbanks";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";

declare function xf:pagoRecaudoPagoAbanksFTOut($fUNDSTRANSFERType as element(),
    $outputParameters as element(ns2:OutputParameters),
    $pagoRecaudo as element(ns1:pagoRecaudo),
    $authorizationCode as xs:string,
    $consultadeparametroscoreResponse as element(ns0:ConsultadeparametroscoreResponse),
    $cuenta as xs:string)
    as element(ns1:pagoRecaudoResponse) {
        <ns1:pagoRecaudoResponse>
            {
                for $PV_NOMBRE_CONTRATO in $outputParameters/ns2:PV_NOMBRE_CONTRATO
                return
                    <CONTRACT_NAME>{ data($PV_NOMBRE_CONTRATO) }</CONTRACT_NAME>
            }
            {
                for $PV_NOMBRE_DEUDOR in $outputParameters/ns2:PV_NOMBRE_DEUDOR
                return
                    <DEBTOR_NAME>{ data($PV_NOMBRE_DEUDOR) }</DEBTOR_NAME>
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
                        <DATE_TIME>{ concat("20",data($DATETIME)) }</DATE_TIME>
                return
                    $result[1]
            }
            {
                for $USERAGENCYNAME in $consultadeparametroscoreResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/USERAGENCYNAME
                return
                    <BRANCH_NAME>{ data($USERAGENCYNAME) }</BRANCH_NAME>
            }
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{ data($fUNDSTRANSFERType/LRPAYTYPE) }</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
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
                for $PV_RECIBO in $outputParameters/ns2:PV_RECIBO
                return
                    <BILL_DETAIL>{ data($PV_RECIBO) }</BILL_DETAIL>
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
declare variable $outputParameters as element(ns2:OutputParameters) external;
declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $authorizationCode as xs:string external;
declare variable $consultadeparametroscoreResponse as element(ns0:ConsultadeparametroscoreResponse) external;
declare variable $cuenta as xs:string external;

xf:pagoRecaudoPagoAbanksFTOut($fUNDSTRANSFERType,
    $outputParameters,
    $pagoRecaudo,
    $authorizationCode,
    $consultadeparametroscoreResponse,
    $cuenta)