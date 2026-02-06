xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns1:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v2/BusinessServices/ABKPA/pagoTarjetaCredito/xsd/pagoTarjetaCredito_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pagoTarjetaCredito";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/pagoTCPAIn/";

declare function xf:pagoTCPAIn($DebitAccount as xs:string,
    $TransactionType as xs:string,
    $SourceBank as xs:string,
    $pagoTarjetaCredito as element(ns1:pagoTarjetaCredito))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CREDIT_CARD_NUMBER>{data($pagoTarjetaCredito/CREDIT_CARD_NUMBER)}</ns0:CREDIT_CARD_NUMBER>
            <ns0:BALANCE_CURRENCY>{ data($pagoTarjetaCredito/BALANCE_CURRENCY) }</ns0:BALANCE_CURRENCY>
            <ns0:PAYMENT_AMOUNT>  
            {
            	if ($SourceBank = 'PA01') then
            		$pagoTarjetaCredito/PAYMENT_AMOUNT/text()
            	else
            		if ($pagoTarjetaCredito/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="ACCOUNT_CURRENCY"]/VALUE/text() = 'USD') then
	            		data($pagoTarjetaCredito/PAYMENT_AMOUNT)
    	        	else
        	    		round-half-to-even($pagoTarjetaCredito/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="ORIGINAL_AMOUNT"]/VALUE/text(), 2)
            }
            </ns0:PAYMENT_AMOUNT>
            <ns0:DEBIT_ACCOUNT>
                {
                    if ($SourceBank != 'PA01') then
                        ($DebitAccount)
                    else 
                        data($pagoTarjetaCredito/DEBIT_ACCOUNT)
                }
			</ns0:DEBIT_ACCOUNT>
            	<ns0:INTERFACE_REFERENCE_NO>
                {
                    for $INTERFACE_REFERENCE_NO  in ($pagoTarjetaCredito/INTERFACE_REFERENCE_NO)  
                    return
                        (data($INTERFACE_REFERENCE_NO))
                }
				</ns0:INTERFACE_REFERENCE_NO>
            	<ns0:CODIGO_TIPO_TRANSACCION>
                {
                    if ($SourceBank != 'PA01') then
                        ($TransactionType)
                    else 
                        0
                }
				</ns0:CODIGO_TIPO_TRANSACCION>
        </ns0:InputParameters>
};

declare variable $DebitAccount as xs:string external;
declare variable $TransactionType as xs:string external;
declare variable $SourceBank as xs:string external;
declare variable $pagoTarjetaCredito as element(ns1:pagoTarjetaCredito) external;

xf:pagoTCPAIn($DebitAccount,
    $TransactionType,
    $SourceBank,
    $pagoTarjetaCredito)