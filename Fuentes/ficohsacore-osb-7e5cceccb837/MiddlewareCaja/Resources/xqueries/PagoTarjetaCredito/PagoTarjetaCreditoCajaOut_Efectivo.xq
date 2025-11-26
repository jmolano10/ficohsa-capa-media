(:: pragma bea:global-element-parameter parameter="$PagodeTCenefectivoCajaResponse" element="ns0:PagodeTCenefectivoCajaResponse" location="../../xsds/PagoTarjetaCreditoCaja_Efectivo/PagoTarjetaCreditoCaja_Efectivo.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoTarjetaCreditoResponse" location="../../xsds/PagoTarjetaCredito/PagoTarjetaCredito.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCredito";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCredito/PagoTarjetaCreditoCajaOut_Efectivo/";

declare function xf:PagoTarjetaCreditoCajaOut_Efectivo($PagodeTCenefectivoCajaResponse as element(ns0:PagodeTCenefectivoCajaResponse),
    $nombreTarjetaTitular as xs:string,
    $nombreAgencia as xs:string)
    as element(ns1:pagoTarjetaCreditoResponse) {
        <ns1:pagoTarjetaCreditoResponse>
            {
                for $CARDNUMBER in $PagodeTCenefectivoCajaResponse/TELLERType/CARDNUMBER
                return
                    <CREDIT_CARD_NUMBER>{ data($CARDNUMBER) }</CREDIT_CARD_NUMBER>
            }
            {
            	if($nombreTarjetaTitular != "") then (
            		<CARD_HOLDER_NAME>{ $nombreTarjetaTitular }</CARD_HOLDER_NAME>
            	) else (
            		""
            	)
            }            
            {
                for $AMOUNTLOCAL1 in $PagodeTCenefectivoCajaResponse/TELLERType/gACCOUNT1/mACCOUNT1[1]/AMOUNTLOCAL1
                return
                    <LCY_PAYMENT>{ data($AMOUNTLOCAL1) }</LCY_PAYMENT>
            }
            {
                for $CURRENCY1 in $PagodeTCenefectivoCajaResponse/TELLERType/CURRENCY1
                return
                    <PAYMENT_CURRENCY>{ data($CURRENCY1) }</PAYMENT_CURRENCY>
            }
            {
                for $NETAMOUNT in $PagodeTCenefectivoCajaResponse/TELLERType/NETAMOUNT
                return
                    <BALANCE_PAYMENT>{ data($NETAMOUNT) }</BALANCE_PAYMENT>
            }
            {
                for $LRCCARDCCY in $PagodeTCenefectivoCajaResponse/TELLERType/LRCCARDCCY
                return
                    <BALANCE_CURRENCY>{ data($LRCCARDCCY) }</BALANCE_CURRENCY>
            }
            {
                for $RATE1 in $PagodeTCenefectivoCajaResponse/TELLERType/RATE1
                return
                    <EXCHANGE_RATE>{ data($RATE1) }</EXCHANGE_RATE>
            }
            {
                for $VALUEDATE2 in $PagodeTCenefectivoCajaResponse/TELLERType/VALUEDATE2
                return
                    <DATE_TIME>{ data($VALUEDATE2) }</DATE_TIME>
            }
            {
                let $result :=
                    for $INPUTTER in $PagodeTCenefectivoCajaResponse/TELLERType/gINPUTTER/INPUTTER
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
                for $RTEFORM in $PagodeTCenefectivoCajaResponse/TELLERType/RTEFORM
                return
                    <RTEFORM>{ data($RTEFORM) }</RTEFORM>
            }
        </ns1:pagoTarjetaCreditoResponse>
};

declare variable $PagodeTCenefectivoCajaResponse as element(ns0:PagodeTCenefectivoCajaResponse) external;
declare variable $nombreTarjetaTitular as xs:string external;
declare variable $nombreAgencia as xs:string external;

xf:PagoTarjetaCreditoCajaOut_Efectivo($PagodeTCenefectivoCajaResponse,
	$nombreTarjetaTitular,
    $nombreAgencia)