(:: pragma bea:global-element-parameter parameter="$cancelaciondecuentaparte2Response" element="ns0:Cancelaciondecuentaparte2Response" location="../../xsds/CancelacionCuenta/XMLSchema_1790235882.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cancelacionCuentaAhorrosResponse" location="../../xsds/CancelacionCuentaAhorros/CancelacionCuentaAhorros.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cancelacionCuentaAhorrosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/CancelacionCuentaAhorros/CancelacionCuentaAhorrosOut/";

declare function xf:CancelacionCuentaAhorrosOut($cancelaciondecuentaparte2Response as element(ns0:Cancelaciondecuentaparte2Response),
    $account as xs:string,
    $accountName as xs:string,
    $branchName as xs:string,
    $userName as xs:string)
    as element(ns1:cancelacionCuentaAhorrosResponse) {
        <ns1:cancelacionCuentaAhorrosResponse>
            {
                for $NETAMOUNT in $cancelaciondecuentaparte2Response/TELLERType/NETAMOUNT
                return
                    <WITHDRAW_AMOUNT>{ data($NETAMOUNT) }</WITHDRAW_AMOUNT>
            }
            {
                for $TELLERID1 in $cancelaciondecuentaparte2Response/TELLERType/TELLERID1
                return
                    <TELLER_ID>{ data($TELLERID1) }</TELLER_ID>
            }
            {
                for $CURRENCY1 in $cancelaciondecuentaparte2Response/TELLERType/CURRENCY1
                return
                    <CURRENCY>{ data($CURRENCY1) }</CURRENCY>
            }
            {
            	if($account != "") then (
            		<ACCOUNT>{ $account }</ACCOUNT>	
            	) else (
            		<ACCOUNT>{ fn:string($cancelaciondecuentaparte2Response/TELLERType/gACCOUNT1/mACCOUNT1[1]/ACCOUNT1/text()) }</ACCOUNT>
            	)
            }
            <ACCOUNT_NAME>{ $accountName }</ACCOUNT_NAME>
            <BRANCH_NAME>{ $branchName }</BRANCH_NAME>
            <USER_NAME>{ $userName }</USER_NAME>
            {
                for $RTEFORM in $cancelaciondecuentaparte2Response/TELLERType/RTEFORM
                return
                    <RTEFORM>{ data($RTEFORM) }</RTEFORM>
            }            
        </ns1:cancelacionCuentaAhorrosResponse>
};

declare variable $cancelaciondecuentaparte2Response as element(ns0:Cancelaciondecuentaparte2Response) external;
declare variable $account as xs:string external;
declare variable $accountName as xs:string external;
declare variable $branchName as xs:string external;
declare variable $userName as xs:string external;

xf:CancelacionCuentaAhorrosOut($cancelaciondecuentaparte2Response,
    $account,
    $accountName,
    $branchName,
    $userName)