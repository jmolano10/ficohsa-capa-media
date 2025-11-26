(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns0:pagoPrestamo" location="../../xsds/PagoPrestamoCaja/PagoPrestamoCaja.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RetiroEfectivoTengo" location="../../../../Middleware/v2/BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/registraTransaccionT24Tengo/";

declare function xf:registraTransaccionT24Tengo($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoPrestamo as element(ns0:pagoPrestamo),
    $creditAccount as xs:string,
    $accountCurrency as xs:string,
    $uuid as xs:string,
    $transactionType as xs:string)
    as element(ns1:RetiroEfectivoTengo) {
        <ns1:RetiroEfectivoTengo>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType>
                <TransactionType>{ $transactionType }</TransactionType>
                {
                    for $DEBIT_ACCOUNT in $pagoPrestamo/DEBIT_ACCOUNT
                    return
                        <DebitAccount>{ data($DEBIT_ACCOUNT) }</DebitAccount>
                }
                <DebitCurrency>{ $accountCurrency }</DebitCurrency>
                <DebitAmount>{ data($pagoPrestamo/PAYMENT_AMOUNT) }</DebitAmount>
                <CreditAccount>{ $creditAccount }</CreditAccount>
                <gPAYMENTDETAILS g = "1">
                    <PaymentDetails>{ fn:concat("PTM-",data($pagoPrestamo/LOAN_NUMBER)) }</PaymentDetails>
                </gPAYMENTDETAILS>
                <LRREFTENGO>{ data($pagoPrestamo/REPAY_TYPE) }</LRREFTENGO>
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns1:RetiroEfectivoTengo>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoPrestamo as element(ns0:pagoPrestamo) external;
declare variable $creditAccount as xs:string external;
declare variable $accountCurrency as xs:string external;
declare variable $uuid as xs:string external;
declare variable $transactionType as xs:string external;

xf:registraTransaccionT24Tengo($autenticacionRequestHeader,
    $pagoPrestamo,
    $creditAccount,
    $accountCurrency,
    $uuid,
    $transactionType)