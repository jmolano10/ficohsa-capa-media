xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/INTFC/transferenciasRegionales/xsd/transferenciasRegionales_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaCuentasResponse" location="../../TransferenciaCuentas/xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transferenciasRegionales";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentasRegional/xq/transferemciaCuentasRegionalOut/";

declare function xf:tramsferemciaCuentasRegionalOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:transferenciaCuentasResponse) {
        <ns1:transferenciaCuentasResponse>
            {
                for $PV_CUENTAREMITENTE in $outputParameters/ns0:PV_CUENTAREMITENTEOUT
                return
                    <DEBIT_ACCOUNT>{ data($PV_CUENTAREMITENTE) }</DEBIT_ACCOUNT>
            }
            {
                for $PV_CUENTABENEFICIARIO in $outputParameters/ns0:PV_CUENTABENEFICIARIOOUT
                return
                    <CREDIT_ACCOUNT>{ data($PV_CUENTABENEFICIARIO) }</CREDIT_ACCOUNT>
            }
            {
                for $PV_CLIENTEREMITENTE in $outputParameters/ns0:PV_CLIENTEREMITENTEOUT
                return
                    <DEBIT_CUSTOMER>{ data($PV_CLIENTEREMITENTE) }</DEBIT_CUSTOMER>
            }
            {
                for $PV_CLIENTEBENEFICIARIO in $outputParameters/ns0:PV_CLIENTEBENEFICIARIOOUT
                return
                    <CREDIT_CUSTOMER>{ data($PV_CLIENTEBENEFICIARIO) }</CREDIT_CUSTOMER>
            }
            {
                for $PV_MONEDACUENTAREMITENTE in $outputParameters/ns0:PV_MONEDACUENTAREMITENTEOUT
                return
                    <DEBIT_CURRENCY>{ data($PV_MONEDACUENTAREMITENTE) }</DEBIT_CURRENCY>
            }
            {
                for $PV_MONEDACUENTABENEFICIARIO in $outputParameters/ns0:PV_MONEDACUENTABENEFICIARIOOUT
                return
                    <CREDIT_CURRENCY>{ data($PV_MONEDACUENTABENEFICIARIO) }</CREDIT_CURRENCY>
            }
            <DEBIT_AMOUNT>{ round-half-to-even(data($outputParameters/ns0:PN_MONTOTRANSACCION),2) }</DEBIT_AMOUNT>
            <CREDIT_AMOUNT>{ round-half-to-even(data($outputParameters/ns0:PN_MONTOOUT), 2) }</CREDIT_AMOUNT>
            <EXCHANGE_RATE>{ data($outputParameters/ns0:PN_TASACAMBIO) }</EXCHANGE_RATE>
            <DATE_TIME>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd',data($outputParameters/ns0:PD_FECHATRANSACCION)) }</DATE_TIME>
            <COMMISSION>{ data($outputParameters/ns0:PN_COMISION_REGIONAL) }</COMMISSION>
        </ns1:transferenciaCuentasResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:tramsferemciaCuentasRegionalOut($outputParameters)