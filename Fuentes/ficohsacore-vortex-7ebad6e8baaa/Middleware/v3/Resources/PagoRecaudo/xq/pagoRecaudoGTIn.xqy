xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/PagoRecaudo/xsd/PagoRecaudo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/PagoRecaudo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoRecaudo/xq/pagoRecaudoGTIn/";

declare function xf:pagoRecaudoGTIn($pagoRecaudo1 as element(ns1:pagoRecaudo),
    $Contrato as xs:string,
    $usuarioCanal as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CONTRACT_ID>{ $Contrato }</ns0:PV_CONTRACT_ID>
            <ns0:PV_DEBTOR_CODE>{ data($pagoRecaudo1/DEBTOR_CODE) }</ns0:PV_DEBTOR_CODE>
            {
                for $DEBTOR_NAME in $pagoRecaudo1/DEBTOR_NAME
                return
                    <ns0:PV_DEBTOR_NAME>{ data($DEBTOR_NAME) }</ns0:PV_DEBTOR_NAME>
            }
            <ns0:PV_PAYMENT_METHOD>{ data($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_METHOD) }</ns0:PV_PAYMENT_METHOD>
            <ns0:PV_PAYMENT_CURRENCY>{ data($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns0:PV_PAYMENT_CURRENCY>
            {
                for $PAYMENT_AMOUNT in $pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                return
                    <ns0:PV_PAYMENT_AMOUNT>{ data($PAYMENT_AMOUNT) }</ns0:PV_PAYMENT_AMOUNT>
            }
            {
                for $DEBIT_ACCOUNT in $pagoRecaudo1/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                return
                    <ns0:PV_DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</ns0:PV_DEBIT_ACCOUNT>
            }
            {
                for $CHEQUE_NUMBER in $pagoRecaudo1/PAYMENT_INFORMATION/CHEQUE_NUMBER
                return
                    <ns0:PV_CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</ns0:PV_CHEQUE_NUMBER>
            }
            {
                for $BANK_CODE in $pagoRecaudo1/PAYMENT_INFORMATION/BANK_CODE
                return
                    <ns0:PV_BANK_CODE>{ data($BANK_CODE) }</ns0:PV_BANK_CODE>
            }
            {
                for $CREDIT_CARD_NUMBER in $pagoRecaudo1/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                return
                    <ns0:PV_CREDIT_CARD_NUMBER>{ data($CREDIT_CARD_NUMBER) }</ns0:PV_CREDIT_CARD_NUMBER>
            }
            {
                for $EXPIRATION_DATE in $pagoRecaudo1/PAYMENT_INFORMATION/EXPIRATION_DATE
                return
                    <ns0:PV_EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</ns0:PV_EXPIRATION_DATE>
            }
            {
                for $BILL_NUMBER in $pagoRecaudo1/BILL_INFORMATION/BILL_NUMBER
                return
                    <ns0:PV_BILL_NUMBER>{ data($BILL_NUMBER) }</ns0:PV_BILL_NUMBER>
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
                    <ns0:PV_EXTENDED_COLLECTION_Y_N>{ data($EXTENDED_COLLECTION_YES_NO) }</ns0:PV_EXTENDED_COLLECTION_Y_N>
            }
            {
                for $DEALSLIP_PICKUP_BRANCH in $pagoRecaudo1/DEALSLIP_PICKUP_BRANCH
                return
                    <ns0:PV_DEALSLIP_PICKUP_BRANCH>{ data($DEALSLIP_PICKUP_BRANCH) }</ns0:PV_DEALSLIP_PICKUP_BRANCH>
            }
            {
                for $ADDITIONAL_INFO in $pagoRecaudo1/ADDITIONAL_INFO
                return
                    <ns0:PV_DATA>
                        {
                            for $DATA in $ADDITIONAL_INFO/DATA
                            return
                                <ns0:PV_DATA_ITEM>{ data($DATA) }</ns0:PV_DATA_ITEM>
                        }
                    </ns0:PV_DATA>
            }
            <ns0:PV_USERNAME>{ $usuarioCanal }</ns0:PV_USERNAME>
        </ns0:InputParameters>
};

declare variable $pagoRecaudo1 as element(ns1:pagoRecaudo) external;
declare variable $Contrato as xs:string external;
declare variable $usuarioCanal as xs:string external;

xf:pagoRecaudoGTIn($pagoRecaudo1,
    $Contrato,
    $usuarioCanal)