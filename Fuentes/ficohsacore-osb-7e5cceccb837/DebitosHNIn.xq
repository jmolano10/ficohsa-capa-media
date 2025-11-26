(:: pragma bea:global-element-parameter parameter="$HeaderElement" element="ns0:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns2:pagoTarjetaCredito" location="../../PagoTarjetaCredito/xsd/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Transfentrecuentasinstrcredito" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/Debitos/xq/DebitosHNIn/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:DebitosHNIn($HeaderElement as element(ns0:RequestHeader),
    $pagoTarjetaCredito as element(ns2:pagoTarjetaCredito),
    $CustomerNumber as xs:string,
    $CustomerName as xs:string,
    $DebitAccountCurrency as xs:string,
    $CreditAmount as xs:string,
    $CreditAccount as xs:string,
    $TransactionType as xs:string)
    as element(ns1:Transfentrecuentasinstrcredito) {
        <ns1:Transfentrecuentasinstrcredito>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($HeaderElement/Authentication/UserName)),data($HeaderElement/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($HeaderElement/Authentication/UserName)),data($HeaderElement/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
	            <gtsControl></gtsControl>
	            <messageId></messageId>
	            <noOfAuth></noOfAuth>
	            <replace></replace>
         	</OfsFunction>
            <FUNDSTRANSFERRETAILCRSALEWSType>
                <TRANSACTIONTYPE>{ $TransactionType }</TRANSACTIONTYPE>
                <DEBITACCOUNT>{ data($pagoTarjetaCredito/DEBIT_ACCOUNT) }</DEBITACCOUNT>
                <DEBITCURRENCY>{ $DebitAccountCurrency }</DEBITCURRENCY>
                <CREDITACCOUNT>{ $CreditAccount }</CREDITACCOUNT>
                <CREDITAMOUNT>
                { 
                	if($DebitAccountCurrency = 'USD') then
                		$pagoTarjetaCredito/PAYMENT_AMOUNT/text()
                	else
                		round-half-to-even($pagoTarjetaCredito/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="ORIGINAL_AMOUNT"]/VALUE/text(), 2)
                }
                </CREDITAMOUNT>
				<gPAYMENTDETAILS>
                    <PAYMENTDETAILS>{ data($pagoTarjetaCredito/CREDIT_CARD_NUMBER) }</PAYMENTDETAILS>
	                <PAYMENTDETAILS>{if (fn:string-length($CustomerName) = 0) then 'Customer name not found' else if (fn:string-length($CustomerName) > 34) then fn:substring($CustomerName, 1, 34) else $CustomerName}</PAYMENTDETAILS>  
	                <PAYMENTDETAILS>{ $CustomerNumber }</PAYMENTDETAILS>
                    {
                        for $DestinationBank in $HeaderElement/Region/DestinationBank
                        return
                            <PAYMENTDETAILS>{ data($DestinationBank) }</PAYMENTDETAILS>
                    }
                </gPAYMENTDETAILS>
                <LRCATEGORY>{ $pagoTarjetaCredito/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="CATEGORY"]/VALUE/text() }</LRCATEGORY>
                <LRSUBCATEG>{ $pagoTarjetaCredito/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="SUBCATEGORY"]/VALUE/text() }</LRSUBCATEG>
                <LRITEM>{ $pagoTarjetaCredito/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="ITEM"]/VALUE/text() }</LRITEM>
                <LRSUBITEM>{ $pagoTarjetaCredito/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="SUBITEM"]/VALUE/text() }</LRSUBITEM>
                <LRGROUP>{ $pagoTarjetaCredito/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="GROUP"]/VALUE/text() }</LRGROUP>                
            </FUNDSTRANSFERRETAILCRSALEWSType>
        </ns1:Transfentrecuentasinstrcredito>
};

declare variable $HeaderElement as element(ns0:RequestHeader) external;
declare variable $pagoTarjetaCredito as element(ns2:pagoTarjetaCredito) external;
declare variable $CustomerNumber as xs:string external;
declare variable $CustomerName as xs:string external;
declare variable $DebitAccountCurrency as xs:string external;
declare variable $CreditAmount as xs:string external;
declare variable $CreditAccount as xs:string external;
declare variable $TransactionType as xs:string external;

xf:DebitosHNIn($HeaderElement,
    $pagoTarjetaCredito,
    $CustomerNumber,
    $CustomerName,
    $DebitAccountCurrency,
    $CreditAmount,
    $CreditAccount,
    $TransactionType)