(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoSeguroResponse1" element="ns0:pagoSeguroResponse" location="../xsd/pagoSeguroTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CNV/registroBitacoraPagoSeguro/xsd/RegistroBitacoraPagoSeguro_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/RegistroBitacoraPagoSeguro";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoSeguroTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoSeguros/xq/registroBitacoraPagoSeguroIn3/";

declare function xf:registroBitacoraPagoSeguroIn3($uuid as xs:string,
    $pagoSeguroRequest as xs:string,
    $responseHeader1 as element(ns2:ResponseHeader),
    $pagoSeguroResponse1 as element(ns0:pagoSeguroResponse))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_UUID>{ $uuid }</ns1:PV_UUID>
            <ns1:PV_CUENTA>{ data($pagoSeguroResponse1/DEBIT_ACCOUNT) }</ns1:PV_CUENTA>
            <ns1:PV_POLIZA>{ data($pagoSeguroResponse1/POLICY_NUMBER) }</ns1:PV_POLIZA>
            <ns1:PV_PRODUCT>{ data($pagoSeguroResponse1/PRODUCT) }</ns1:PV_PRODUCT>
            <ns1:PV_CREDICT_ACCOUNT>{ data($pagoSeguroResponse1/CREDIT_ACCOUNT) }</ns1:PV_CREDICT_ACCOUNT>
            <ns1:PV_PAYMENT_CURRENCY>{ data($pagoSeguroResponse1/PAYMENT_CURRENCY) }</ns1:PV_PAYMENT_CURRENCY>
            <ns1:PV_PAYMENT_AMOUNT>{ data($pagoSeguroResponse1/PAYMENT_AMOUNT) }</ns1:PV_PAYMENT_AMOUNT>
            <ns1:PV_STATUS>P</ns1:PV_STATUS>
            <ns1:PV_CERTIFICATE_NUMB>{ data($pagoSeguroResponse1/CERTIFICATE_NUMBER) }</ns1:PV_CERTIFICATE_NUMB>
            <ns1:PV_INSTALLMENT_NUMB>{ data($pagoSeguroResponse1/INSTALLMENT_NUMBER) }</ns1:PV_INSTALLMENT_NUMB>
            <ns1:PV_TRANSACTION_ID>{ data($responseHeader1/transactionId) }</ns1:PV_TRANSACTION_ID>
            <ns1:PV_MESSAGE_ERROR></ns1:PV_MESSAGE_ERROR>
        </ns1:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $pagoSeguroRequest as xs:string external;
declare variable $responseHeader1 as element(ns2:ResponseHeader) external;
declare variable $pagoSeguroResponse1 as element(ns0:pagoSeguroResponse) external;

xf:registroBitacoraPagoSeguroIn3($uuid,
    $pagoSeguroRequest,
    $responseHeader1,
    $pagoSeguroResponse1)