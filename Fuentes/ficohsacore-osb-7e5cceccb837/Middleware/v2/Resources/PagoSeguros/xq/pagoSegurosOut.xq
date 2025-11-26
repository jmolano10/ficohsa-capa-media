(:: pragma bea:global-element-parameter parameter="$pagoSeguro1" element="ns1:pagoSeguro" location="../xsd/pagoSeguroTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transfmodelbankentrecuentasResponse1" element="ns0:TransfmodelbankentrecuentasResponse" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoSeguroResponse" location="../xsd/pagoSeguroTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoSeguroTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoSeguros/xq/pagoSegurosOut/";

declare function xf:pagoSegurosOut($pagoSeguro1 as element(ns1:pagoSeguro),
    $transfmodelbankentrecuentasResponse1 as element(ns0:TransfmodelbankentrecuentasResponse))
    as element(ns1:pagoSeguroResponse) {
        <ns1:pagoSeguroResponse>
            {
                for $PRODUCT in $pagoSeguro1/PRODUCT
                return
                    <PRODUCT>{ data($PRODUCT) }</PRODUCT>
            }
            {
                for $POLICY_NUMBER in $pagoSeguro1/POLICY_NUMBER
                return
                    <POLICY_NUMBER>{ data($POLICY_NUMBER) }</POLICY_NUMBER>
            }
            {
                for $CERTIFICATE_NUMBER in $pagoSeguro1/CERTIFICATE_NUMBER
                return
                    <CERTIFICATE_NUMBER>{ data($CERTIFICATE_NUMBER) }</CERTIFICATE_NUMBER>
            }
            {
                for $INSTALLMENT_NUMBER in $pagoSeguro1/INSTALLMENT_NUMBER
                return
                    <INSTALLMENT_NUMBER>{ data($INSTALLMENT_NUMBER) }</INSTALLMENT_NUMBER>
            }
            {
                for $INSTALLMENT_AMOUNT in $pagoSeguro1/INSTALLMENT_AMOUNT
                return
                    <INSTALLMENT_AMOUNT>{ data($INSTALLMENT_AMOUNT) }</INSTALLMENT_AMOUNT>
            }
            <DEBIT_ACCOUNT>{ data($transfmodelbankentrecuentasResponse1/FUNDSTRANSFERType/DEBITACCTNO) }</DEBIT_ACCOUNT>
            <CREDIT_ACCOUNT>{ data($transfmodelbankentrecuentasResponse1/FUNDSTRANSFERType/CREDITACCTNO) }</CREDIT_ACCOUNT>
            <PAYMENT_CURRENCY>{ data($transfmodelbankentrecuentasResponse1/FUNDSTRANSFERType/DEBITCURRENCY) }</PAYMENT_CURRENCY>
            <PAYMENT_AMOUNT>{ data($transfmodelbankentrecuentasResponse1/FUNDSTRANSFERType/DEBITAMOUNT) }</PAYMENT_AMOUNT>
        </ns1:pagoSeguroResponse>
};

declare variable $pagoSeguro1 as element(ns1:pagoSeguro) external;
declare variable $transfmodelbankentrecuentasResponse1 as element(ns0:TransfmodelbankentrecuentasResponse) external;

xf:pagoSegurosOut($pagoSeguro1,
    $transfmodelbankentrecuentasResponse1)