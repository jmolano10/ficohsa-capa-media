xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opTransferenciaCuentaRespuesta" element="ns3:opTransferenciaCuentaRespuesta" location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:transferenciaCuentasResponse" location="../xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/TransferenciaCuentaNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";

declare function xf:TransferenciaCuentaNIOut($opTransferenciaCuentaRespuesta as element(ns3:opTransferenciaCuentaRespuesta))
    as element(ns0:transferenciaCuentasResponse) {
        <ns0:transferenciaCuentasResponse>
            {
                for $codCuentaHabiente in $opTransferenciaCuentaRespuesta/ns1:transaccionCuenta/ns1:cuentaDebito/ns1:codCuentaHabiente
                return
                    <DEBIT_ACCOUNT>{ data($codCuentaHabiente) }</DEBIT_ACCOUNT>
            }
            {
                for $codCuentaHabiente in $opTransferenciaCuentaRespuesta/ns1:transaccionCuenta/ns1:cuentaCredito/ns1:codCuentaHabiente
                return
                    <CREDIT_ACCOUNT>{ data($codCuentaHabiente) }</CREDIT_ACCOUNT>
            }
            <DEBIT_CUSTOMER>{ data($opTransferenciaCuentaRespuesta/ns1:transaccionCuenta/ns1:cuentaDebito/ns1:cliente/ns1:codCliente) }</DEBIT_CUSTOMER>
            <CREDIT_CUSTOMER>{ data($opTransferenciaCuentaRespuesta/ns1:transaccionCuenta/ns1:cuentaCredito/ns1:cliente/ns1:codCliente) }</CREDIT_CUSTOMER>            {
                for $valSimboloMoneda in $opTransferenciaCuentaRespuesta/ns1:transaccionCuenta/ns1:cuentaDebito/ns1:moneda/ns1:valSimboloMoneda
                return
                    <DEBIT_CURRENCY>{ data($valSimboloMoneda) }</DEBIT_CURRENCY>
            }
            {
                for $valSimboloMoneda in $opTransferenciaCuentaRespuesta/ns1:transaccionCuenta/ns1:cuentaCredito/ns1:moneda/ns1:valSimboloMoneda
                return
                    <CREDIT_CURRENCY>{ data($valSimboloMoneda) }</CREDIT_CURRENCY>
            }
            <DEBIT_AMOUNT>{ fn:round-half-to-even(xs:decimal(data($opTransferenciaCuentaRespuesta/ns1:transaccionCuenta/ns1:montoDebito)),2) }</DEBIT_AMOUNT>
            <CREDIT_AMOUNT>{ fn:round-half-to-even(xs:decimal(data($opTransferenciaCuentaRespuesta/ns1:transaccionCuenta/ns1:montoCredito)),2) }</CREDIT_AMOUNT>
            <EXCHANGE_RATE>{ fn:round-half-to-even(xs:decimal(data($opTransferenciaCuentaRespuesta/ns1:transaccionCuenta/ns1:tasaCambio)),4) }</EXCHANGE_RATE>
            <INTERNATIONAL_ACCOUNT_NUMBER_DEBIT_ACCOUNT>{ data($opTransferenciaCuentaRespuesta/ns1:transaccionCuenta/ns1:cuentaDebito/ns1:codigoIBAN) }</INTERNATIONAL_ACCOUNT_NUMBER_DEBIT_ACCOUNT>
            <INTERNATIONAL_ACCOUNT_NUMBER_CREDIT_ACCOUNT>{ data($opTransferenciaCuentaRespuesta/ns1:transaccionCuenta/ns1:cuentaCredito/ns1:codigoIBAN) }</INTERNATIONAL_ACCOUNT_NUMBER_CREDIT_ACCOUNT>



        </ns0:transferenciaCuentasResponse>
};

declare variable $opTransferenciaCuentaRespuesta as element(ns3:opTransferenciaCuentaRespuesta) external;

xf:TransferenciaCuentaNIOut($opTransferenciaCuentaRespuesta)