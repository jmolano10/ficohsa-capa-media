(:: pragma bea:local-element-complex-parameter parameter="$SourceRegionalDetails" type="RegionalDetails/SOURCE" location="../../ArtefactosGenerales/xsd/KeyValuePair.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Transfentrecuentasinstrcredito" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/Debitos/xq/DebitsHNIn/";

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

declare function xf:DebitsHNIn($UserName as xs:string,
    $Password as xs:string,
    $SourceBank as xs:string,
    $TransactionType as xs:string,
    $CustomerNumber as xs:string,
    $CustomerName as xs:string,
    $SourceAccount as xs:string,
    $SourceAccountCurrency as xs:string,
    $Amount as xs:string,
    $DestinationAccount as xs:string,
    $CreditCardNumber as xs:string,
    $SourceRegionalDetails as element())
    as element(ns0:Transfentrecuentasinstrcredito) {
        <ns0:Transfentrecuentasinstrcredito>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over(getUsername($UserName),$UserName) }</userName>
                <password>{ fn-bea:fail-over(getPassword($UserName),$Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
            	<gtsControl></gtsControl>
            	<messageId></messageId>
            	<noOfAuth></noOfAuth>
            	<replace></replace>
            </OfsFunction>
            <FUNDSTRANSFERRETAILCRSALEWSType>
                <TRANSACTIONTYPE>{ $TransactionType }</TRANSACTIONTYPE>
                <DEBITACCOUNT>{ $SourceAccount }</DEBITACCOUNT>
                <DEBITCURRENCY>{ $SourceAccountCurrency }</DEBITCURRENCY>
                <CREDITACCOUNT>{ $DestinationAccount }</CREDITACCOUNT>
                <CREDITAMOUNT>{ $Amount }</CREDITAMOUNT>
    			<gPAYMENTDETAILS>
	                <PAYMENTDETAILS>{ $CreditCardNumber }</PAYMENTDETAILS>
	                <PAYMENTDETAILS>{if (fn:string-length($CustomerName) = 0) then 'Customer name not found' else if (fn:string-length($CustomerName) > 34) then fn:substring($CustomerName, 1, 34) else $CustomerName}</PAYMENTDETAILS>  
	                <PAYMENTDETAILS>{ $CustomerNumber }</PAYMENTDETAILS>
	                <PAYMENTDETAILS>{ data($SourceBank) }</PAYMENTDETAILS>
            	</gPAYMENTDETAILS>
            	<LRCATEGORY>{ $SourceRegionalDetails/KV_PAIR[KEY="CATEGORY"]/VALUE/text() }</LRCATEGORY>
                <LRSUBCATEG>{ $SourceRegionalDetails/KV_PAIR[KEY="SUBCATEGORY"]/VALUE/text() }</LRSUBCATEG>
                <LRITEM>{ $SourceRegionalDetails/KV_PAIR[KEY="ITEM"]/VALUE/text() }</LRITEM>
                <LRSUBITEM>{ $SourceRegionalDetails/KV_PAIR[KEY="SUBITEM"]/VALUE/text() }</LRSUBITEM>
                <LRGROUP>{ $SourceRegionalDetails/KV_PAIR[KEY="GROUP"]/VALUE/text() }</LRGROUP>   
            </FUNDSTRANSFERRETAILCRSALEWSType>
        </ns0:Transfentrecuentasinstrcredito>
};

declare variable $UserName as xs:string external;
declare variable $Password as xs:string external;
declare variable $SourceBank as xs:string external;
declare variable $TransactionType as xs:string external;
declare variable $CustomerNumber as xs:string external;
declare variable $CustomerName as xs:string external;
declare variable $SourceAccount as xs:string external;
declare variable $SourceAccountCurrency as xs:string external;
declare variable $Amount as xs:string external;
declare variable $DestinationAccount as xs:string external;
declare variable $CreditCardNumber as xs:string external;
declare variable $SourceRegionalDetails as element() external;

xf:DebitsHNIn($UserName,
    $Password,
    $SourceBank,
    $TransactionType,
    $CustomerNumber,
    $CustomerName,
    $SourceAccount,
    $SourceAccountCurrency,
    $Amount,
    $DestinationAccount,
    $CreditCardNumber,
    $SourceRegionalDetails)
