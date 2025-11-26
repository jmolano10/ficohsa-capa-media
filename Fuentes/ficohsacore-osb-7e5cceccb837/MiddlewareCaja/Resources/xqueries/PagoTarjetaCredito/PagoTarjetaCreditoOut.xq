xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagodeTarjetaCreditoResponse" element="ns0:PagodeTarjetaCreditoResponse" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoTarjetaCreditoResponse" location="../../xsds/PagoTarjetaCredito/PagoTarjetaCredito.xsd" ::)

declare namespace xf = "http://tempuri.org/MWCaja/PagoTarjetaCreditoOut/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCredito";

declare function xf:PagoTarjetaCreditoOut($pagodeTarjetaCreditoResponse as element(ns0:PagodeTarjetaCreditoResponse),
    $nombreTarjetaTitular as xs:string,
    $nombreAgencia as xs:string)
    as element(ns1:pagoTarjetaCreditoResponse) {
         <ns1:pagoTarjetaCreditoResponse>
            {
                for $CREDITCARDNUM in $pagodeTarjetaCreditoResponse/TELLERFINANCIALSERVICESType/CREDITCARDNUM
                return
                    <CREDIT_CARD_NUMBER>{ data($CREDITCARDNUM) }</CREDIT_CARD_NUMBER>
            }
            {
            	if($nombreTarjetaTitular != "") then (
            		<CARD_HOLDER_NAME>{ $nombreTarjetaTitular }</CARD_HOLDER_NAME>
            	) else (
            		""
            	)
            }
            {
                for $AMOUNT in $pagodeTarjetaCreditoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/AMOUNT
                return
                    <LCY_PAYMENT>{ data($AMOUNT) }</LCY_PAYMENT>
            }
            {
                for $CURRENCY in $pagodeTarjetaCreditoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/CURRENCY
                return
                    <PAYMENT_CURRENCY>{ data($CURRENCY) }</PAYMENT_CURRENCY>
            }
            {
                for $LROTHAMT in $pagodeTarjetaCreditoResponse/TELLERFINANCIALSERVICESType/LROTHAMT
                return
                    <BALANCE_PAYMENT>{ data($LROTHAMT) }</BALANCE_PAYMENT>
            }
            {
                for $LRCRCCY in $pagodeTarjetaCreditoResponse/TELLERFINANCIALSERVICESType/LRCRCCY
                return
                    <BALANCE_CURRENCY>{ data($LRCRCCY) }</BALANCE_CURRENCY>
            }
            {
                for $LRCUSTRATE in $pagodeTarjetaCreditoResponse/TELLERFINANCIALSERVICESType/gLR.ECONOMIC.ACT/mLR.ECONOMIC.ACT[1]/LRCUSTRATE
                return
                    <EXCHANGE_RATE>{ data($LRCUSTRATE) }</EXCHANGE_RATE>
            }
            {
                for $SURROGATEAC in $pagodeTarjetaCreditoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/SURROGATEAC
                return
                    <DEBIT_ACCOUNT>{ data($SURROGATEAC) }</DEBIT_ACCOUNT>
            }
            {
                for $CHEQUENUMBER in $pagodeTarjetaCreditoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/CHEQUENUMBER
                return
                    <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
            }
            {
                for $SORTCODE in $pagodeTarjetaCreditoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/SORTCODE
                return
                    <BANK_CODE>{ data($SORTCODE) }</BANK_CODE>
            }
            {
                let $result :=
                    for $DATETIME in $pagodeTarjetaCreditoResponse/TELLERFINANCIALSERVICESType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ data($DATETIME) }</DATE_TIME>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $INPUTTER in $pagodeTarjetaCreditoResponse/TELLERFINANCIALSERVICESType/gINPUTTER/INPUTTER
                    return
                        <INPUTTER>{ fn:tokenize(data($INPUTTER), "_"),2 }</INPUTTER>
                return
                    $result[1]
            }
            {
            	if($nombreAgencia != "") then (
            		<BRANCH_NAME>{ $nombreAgencia }</BRANCH_NAME>
            	) else (
            	""
            	)
            }            
            {
                for $RTEFORM in $pagodeTarjetaCreditoResponse/TELLERFINANCIALSERVICESType/RTEFORM
                return
                    <RTEFORM>{ data($RTEFORM) }</RTEFORM>
            }
        </ns1:pagoTarjetaCreditoResponse>
};

declare variable $pagodeTarjetaCreditoResponse as element(ns0:PagodeTarjetaCreditoResponse) external;
declare variable $nombreTarjetaTitular as xs:string external;
declare variable $nombreAgencia as xs:string external;

xf:PagoTarjetaCreditoOut($pagodeTarjetaCreditoResponse,
    $nombreTarjetaTitular,
    $nombreAgencia)
