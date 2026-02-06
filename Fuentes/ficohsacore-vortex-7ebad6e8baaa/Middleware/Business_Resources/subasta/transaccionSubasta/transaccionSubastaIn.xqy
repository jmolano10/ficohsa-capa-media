xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transaccionSubasta" element="ns1:transaccionSubasta" location="transaccionSubastaTypes.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$status" type="ns0:Status" location="../../Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$fUNDSTRANSFERType" type="ns0:FUNDSTRANSFERType" location="../../Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Transacciondesubasta" location="../Resources/XMLSchema_-1390898219.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transaccionSubastaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/subasta/transaccionSubasta/transaccionSubastaIn/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:transaccionSubastaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $transaccionSubasta as element(ns1:transaccionSubasta),
    $status as element(),
    $fUNDSTRANSFERType as element(),
    $cuentaServicio as xs:string,
    $uuid as xs:string)
    as element(ns0:Transacciondesubasta) {
        <ns0:Transacciondesubasta>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
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
        </ns0:Transacciondesubasta>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $transaccionSubasta as element(ns1:transaccionSubasta) external;
declare variable $status as element() external;
declare variable $fUNDSTRANSFERType as element() external;
declare variable $cuentaServicio as xs:string external;
declare variable $uuid as xs:string external;

xf:transaccionSubastaIn($autenticacionRequestHeader,
    $transaccionSubasta,
    $status,
    $fUNDSTRANSFERType,
    $cuentaServicio,
    $uuid)