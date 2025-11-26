(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transaccionSubasta" element="ns2:transaccionSubasta" location="../../../../Business_Resources/subasta/transaccionSubasta/transaccionSubastaTypes.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$status" type="ns1:Status" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$fUNDSTRANSFERType" type="ns1:FUNDSTRANSFERType" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Transacciondesubasta" location="../../../../Business_Resources/subasta/Resources/XMLSchema_-1390898219.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transaccionSubastaTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionSubasta/xq/transaccionSubastaIn/";

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

declare function xf:transaccionSubastaIn($requestHeader as element(ns0:RequestHeader),
    $transaccionSubasta as element(ns2:transaccionSubasta),
    $status as element(),
    $fUNDSTRANSFERType as element(),
    $cuentaServicio as xs:string,
    $uuid as xs:string)
    as element(ns1:Transacciondesubasta) {
        <ns1:Transacciondesubasta>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
				</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl></gtsControl>
				<messageId>{ $uuid }</messageId>
				<noOfAuth>0</noOfAuth>
				<replace></replace>
            </OfsFunction>
            <FUNDSTRANSFERAFFPROCESSWSType>
                <DebitAcctNo>{ data($transaccionSubasta/DEBIT_ACCOUNT) }</DebitAcctNo>
                <DebitCurrency>HNL</DebitCurrency>
                {
                	let $TRANSACTION_TYPE := fn:string($transaccionSubasta/TRANSACTION_TYPE/text())
                	return
                		if($TRANSACTION_TYPE = "ACCTTRF") then (
                			<DebitAmount>{ data($fUNDSTRANSFERType/DEBITAMOUNT) }</DebitAmount>
                			
                		) else if($TRANSACTION_TYPE = "INTLTRF") then (
                			<DebitAmount>{ fn-bea:fail-over(fn-bea:format-number(round-half-to-even(number($fUNDSTRANSFERType/LRAUCRATE)*number($fUNDSTRANSFERType/LRUSDAUCAMT),4),"######0.00"),0) }</DebitAmount>	
                			
                		) else if($TRANSACTION_TYPE = "CASHCHQ") then (
                			<DebitAmount>{ fn-bea:fail-over(fn-bea:format-number(round-half-to-even(number($fUNDSTRANSFERType/LRAUCRATE)*number($fUNDSTRANSFERType/LRUSDAUCAMT),4),"######0.00"),0) }</DebitAmount>
                			
                		) else ()
                }
                <DebitTheirReference>{ data($status/transactionId) }</DebitTheirReference>
                <InitialCrAcct>{ data($fUNDSTRANSFERType/CREDITACCTNO) }</InitialCrAcct>
                <CreditAcctNo>{ $cuentaServicio }</CreditAcctNo>
                {
                    for $ADDITIONAL_INFO in $transaccionSubasta/ADDITIONAL_INFO
                    return
                        <gLR.TIP.TRANS>
                            {
                                for $DOCUMENTS in $ADDITIONAL_INFO/DOCUMENTS
                                return
                                    <mLR.TIP.TRANS>
                                        {
                                            for $TYPE in $DOCUMENTS/TYPE
                                            return
                                                <LRTIPTRANS>{ data($TYPE) }</LRTIPTRANS>
                                        }
                                        {
                                            for $BENEFICIARY_NAME in $DOCUMENTS/BENEFICIARY_NAME
                                            return
                                                <LRDESTIDIV>{ data($BENEFICIARY_NAME) }</LRDESTIDIV>
                                        }
                                        {
                                            for $NUMBER_TRANS in $DOCUMENTS/NUMBER_TRANS
                                            return
                                                <LRNUMTRANS>{ data($NUMBER_TRANS) }</LRNUMTRANS>
                                        }
                                        {
                                            for $DATE_TRANS in $DOCUMENTS/DATE_TRANS
                                            return
                                                <LRFECHEMIS>{ data($DATE_TRANS) }</LRFECHEMIS>
                                        }
                                        {
                                            for $AMOUNT_TRANSACTION in $DOCUMENTS/AMOUNT_TRANSACTION
                                            return
                                                <LRMONTTRANS>{ data($AMOUNT_TRANSACTION) }</LRMONTTRANS>
                                        }
                                        {
                                            for $PAYMENT_PARTIAL in $DOCUMENTS/PAYMENT_PARTIAL
                                            return
                                                <LRABOPARC>{ data($PAYMENT_PARTIAL) }</LRABOPARC>
                                        }
                                        {
                                            for $AMOUNT_BALANCE in $DOCUMENTS/AMOUNT_BALANCE
                                            return
                                                <LRSALDPEND>{ data($AMOUNT_BALANCE) }</LRSALDPEND>
                                        }
                                        {
                                            for $DETAIL_PAYMENT in $DOCUMENTS/DETAIL_PAYMENT
                                            return
                                                <LRDETALPAG>{ data($DETAIL_PAYMENT) }</LRDETALPAG>
                                        }
                                        {
                                            for $BENEFICIARY_DOCUMENT_ID in $DOCUMENTS/BENEFICIARY_DOCUMENT_ID
                                            return
                                                <LRNUMIDEN>{ data($BENEFICIARY_DOCUMENT_ID) }</LRNUMIDEN>
                                        }
                                    </mLR.TIP.TRANS>
                            }
                        </gLR.TIP.TRANS>
                }
            </FUNDSTRANSFERAFFPROCESSWSType>
        </ns1:Transacciondesubasta>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $transaccionSubasta as element(ns2:transaccionSubasta) external;
declare variable $status as element() external;
declare variable $fUNDSTRANSFERType as element() external;
declare variable $cuentaServicio as xs:string external;
declare variable $uuid as xs:string external;

xf:transaccionSubastaIn($requestHeader,
    $transaccionSubasta,
    $status,
    $fUNDSTRANSFERType,
    $cuentaServicio,
    $uuid)
