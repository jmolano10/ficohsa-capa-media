(:: pragma bea:global-element-parameter parameter="$retiroEfectivoTengoResponse" element="ns0:RetiroEfectivoTengoResponse" location="../../../BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:depositoACuentaResponse" location="../xsd/depositoACuentaCBTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoACuentaCBTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DepositoACuentaCB/xq/depositoACuentaCBOut/";

declare function xf:depositoACuentaCBOut($DepositType as xs:string,
    $retiroEfectivoTengoResponse as element(ns0:RetiroEfectivoTengoResponse))
    as element(ns1:depositoACuentaResponse) {
        <ns1:depositoACuentaResponse>
            <ACCOUNT_NUMBER>{ data($retiroEfectivoTengoResponse/FUNDSTRANSFERType/CREDITACCTNO) }</ACCOUNT_NUMBER>
            <CURRENCY>{ data($retiroEfectivoTengoResponse/FUNDSTRANSFERType/DEBITCURRENCY) }</CURRENCY>
            <DEPOSIT_ITEMS>
                <DEPOSIT_ITEM>
                    <DEPOSIT_TYPE>{ $DepositType }</DEPOSIT_TYPE>
                    <AMOUNT>{ data($retiroEfectivoTengoResponse/FUNDSTRANSFERType/DEBITAMOUNT) }</AMOUNT>
                    <BANK_CODE>{ data($retiroEfectivoTengoResponse/FUNDSTRANSFERType/gBENBANK/BENBANK) }</BANK_CODE>
                </DEPOSIT_ITEM>
            </DEPOSIT_ITEMS>
                    <DATE_TIME>{ data($retiroEfectivoTengoResponse/FUNDSTRANSFERType/CREDITVALUEDATE) }</DATE_TIME>
        </ns1:depositoACuentaResponse>
};

declare variable $DepositType as xs:string external;
declare variable $retiroEfectivoTengoResponse as element(ns0:RetiroEfectivoTengoResponse) external;

xf:depositoACuentaCBOut($DepositType,
    $retiroEfectivoTengoResponse)