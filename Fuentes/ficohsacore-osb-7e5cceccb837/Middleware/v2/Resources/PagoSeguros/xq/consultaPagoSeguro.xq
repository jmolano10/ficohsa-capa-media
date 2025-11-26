(:: pragma bea:global-element-parameter parameter="$pagoSeguro1" element="ns0:pagoSeguro" location="../xsd/pagoSeguroTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CNV/consultaPagoSeguro/xsd/ConsultaPagoSeguro_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaPagoSeguro";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoSeguroTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoSeguros/xq/consultaPagoSeguro/";

declare function xf:consultaPagoSeguro($pagoSeguro1 as element(ns0:pagoSeguro))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_NUMERO_POLIZA>{ data($pagoSeguro1/POLICY_NUMBER) }</ns1:PV_NUMERO_POLIZA>
            <ns1:PV_NUMERO_CUENTA>{ data($pagoSeguro1/DEBIT_ACCOUNT) }</ns1:PV_NUMERO_CUENTA>
            <ns1:PN_NUMERO_CUOTA>{ xs:integer(data($pagoSeguro1/INSTALLMENT_NUMBER)) }</ns1:PN_NUMERO_CUOTA>
        </ns1:InputParameters>
};

declare variable $pagoSeguro1 as element(ns0:pagoSeguro) external;

xf:consultaPagoSeguro($pagoSeguro1)