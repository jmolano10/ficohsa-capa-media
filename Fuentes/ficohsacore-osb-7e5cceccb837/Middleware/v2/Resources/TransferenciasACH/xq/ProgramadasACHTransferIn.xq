(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest1" element="ns0:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaCuentasRequest" location="../../../../Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/ProgramadasACHTransferIn/";

declare function xf:ProgramadasACHTransferIn($transferenciasACHRequest1 as element(ns0:transferenciasACHRequest),
	$CreditAccount as xs:string,
	$Commission as xs:string)
    as element(ns1:transferenciaCuentasRequest) {
        <ns1:transferenciaCuentasRequest>
            <DEBIT_ACCOUNT>{ data($transferenciasACHRequest1/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
            <CREDIT_ACCOUNT>{ $CreditAccount }</CREDIT_ACCOUNT>
            <CURRENCY>{ data($transferenciasACHRequest1/CREDIT_CURRENCY) }</CURRENCY>
            <TRANSFER_AMOUNT>{ xs:double(data($transferenciasACHRequest1/TRANSFER_AMOUNT)) + xs:double($Commission) }</TRANSFER_AMOUNT>
            <DESCRIPTION>{ data($transferenciasACHRequest1/TRANSACTION_DESCRIPTION) }</DESCRIPTION>
            <INTERFACE_REFERENCE_NO/>
        </ns1:transferenciaCuentasRequest>
};

declare variable $transferenciasACHRequest1 as element(ns0:transferenciasACHRequest) external;
declare variable $CreditAccount as xs:string external;
declare variable $Commission as xs:string external;

xf:ProgramadasACHTransferIn($transferenciasACHRequest1,$CreditAccount,$Commission)