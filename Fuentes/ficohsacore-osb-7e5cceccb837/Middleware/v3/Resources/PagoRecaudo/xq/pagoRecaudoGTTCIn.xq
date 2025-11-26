(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns0:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/PagoRecaudo/xsd/PagoRecaudo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/PagoRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoRecaudo/xq/pagoRecaudoGTTCIn/";

declare function xf:pagoRecaudoGTTCIn($pagoRecaudo1 as element(ns0:pagoRecaudo),
    $Contrato as xs:string,
    $usuarioCanal as xs:string,
    $idRefConsumo as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CONTRACT_ID>{ $Contrato }</ns1:PV_CONTRACT_ID>
            <ns1:PV_DEBTOR_CODE>{ data($pagoRecaudo1/DEBTOR_CODE) }</ns1:PV_DEBTOR_CODE>
            {
                for $DEBTOR_NAME in $pagoRecaudo1/DEBTOR_NAME
                return
                    <ns1:PV_DEBTOR_NAME>{ data($DEBTOR_NAME) }</ns1:PV_DEBTOR_NAME>
            }
            <ns1:PV_PAYMENT_METHOD>{ data($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_METHOD) }</ns1:PV_PAYMENT_METHOD>
            <ns1:PV_PAYMENT_CURRENCY>{ data($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns1:PV_PAYMENT_CURRENCY>
            {
                for $PAYMENT_AMOUNT in $pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                return
                    <ns1:PV_PAYMENT_AMOUNT>{ data($PAYMENT_AMOUNT) }</ns1:PV_PAYMENT_AMOUNT>
            }
            {
                for $DEBIT_ACCOUNT in $pagoRecaudo1/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                return
                    <ns1:PV_DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</ns1:PV_DEBIT_ACCOUNT>
            }
            {
                for $CHEQUE_NUMBER in $pagoRecaudo1/PAYMENT_INFORMATION/CHEQUE_NUMBER
                return
                    <ns1:PV_CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</ns1:PV_CHEQUE_NUMBER>
            }
            {
                for $BANK_CODE in $pagoRecaudo1/PAYMENT_INFORMATION/BANK_CODE
                return
                    <ns1:PV_BANK_CODE>{ data($BANK_CODE) }</ns1:PV_BANK_CODE>
            }
            {
                for $CREDIT_CARD_NUMBER in $pagoRecaudo1/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                return
                    <ns1:PV_CREDIT_CARD_NUMBER>{ data($CREDIT_CARD_NUMBER) }</ns1:PV_CREDIT_CARD_NUMBER>
            }
            {
                for $EXPIRATION_DATE in $pagoRecaudo1/PAYMENT_INFORMATION/EXPIRATION_DATE
                return
                    <ns1:PV_EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</ns1:PV_EXPIRATION_DATE>
            }
            {
                for $BILL_NUMBER in $pagoRecaudo1/BILL_INFORMATION/BILL_NUMBER
                return
                    <ns1:PV_BILL_NUMBER>{ data($BILL_NUMBER) }</ns1:PV_BILL_NUMBER>
            }
            {
                for $DUE_DATE in $pagoRecaudo1/BILL_INFORMATION/DUE_DATE
                return
                	<ns0:PV_DUE_DATE>
            		{
            			if($Contrato = '182' or $Contrato = '198') then (
                    		fn:concat(fn:substring(data($DUE_DATE),7,2),'/',fn:substring(data($DUE_DATE),5,2),'/',fn:substring(data($DUE_DATE),1,4))
                    	) else (
                    		data($DUE_DATE)
                    	)
                    }
                    </ns0:PV_DUE_DATE>
            }
            {
                for $EXTENDED_COLLECTION_YES_NO in $pagoRecaudo1/EXTENDED_COLLECTION_YES_NO
                return
                    <ns1:PV_EXTENDED_COLLECTION_Y_N>{ data($EXTENDED_COLLECTION_YES_NO) }</ns1:PV_EXTENDED_COLLECTION_Y_N>
            }
            {
                for $DEALSLIP_PICKUP_BRANCH in $pagoRecaudo1/DEALSLIP_PICKUP_BRANCH
                return
                    <ns1:PV_DEALSLIP_PICKUP_BRANCH>{ data($DEALSLIP_PICKUP_BRANCH) }</ns1:PV_DEALSLIP_PICKUP_BRANCH>
            }
            <ns1:PV_DATA>
                {
                    for $DATA in $pagoRecaudo1/ADDITIONAL_INFO/DATA
                    return
                        <ns1:PV_DATA_ITEM>{ data($DATA) }</ns1:PV_DATA_ITEM>
                }
            </ns1:PV_DATA>
            <ns1:PV_USERNAME>{ $usuarioCanal }</ns1:PV_USERNAME>
            <ns1:PV_ID_REFERENCIA>{ $idRefConsumo }</ns1:PV_ID_REFERENCIA>
        </ns1:InputParameters>
};

declare variable $pagoRecaudo1 as element(ns0:pagoRecaudo) external;
declare variable $Contrato as xs:string external;
declare variable $usuarioCanal as xs:string external;
declare variable $idRefConsumo as xs:string external;

xf:pagoRecaudoGTTCIn($pagoRecaudo1,
    $Contrato,
    $usuarioCanal,
    $idRefConsumo)
