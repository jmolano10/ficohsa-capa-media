xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest" element="ns0:transferenciaCuentasRequest" location="../xsd/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opTransferenciaCuentaSolicitud" location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd" ::)

declare namespace ns2 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/transferenciaCuentasNIIn/";

declare function xf:transferenciaCuentasNIIn($transferenciaCuentasRequest as element(ns0:transferenciaCuentasRequest))
    as element(ns2:opTransferenciaCuentaSolicitud) {
        <ns2:opTransferenciaCuentaSolicitud>
            <ns1:contextoTransaccional>
                <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
            </ns1:contextoTransaccional>
            <ns1:cuentaDebito>
                <ns1:codCuentaHabiente>{ data($transferenciaCuentasRequest/DEBIT_ACCOUNT) }</ns1:codCuentaHabiente>
            </ns1:cuentaDebito>
            <ns1:cuentaCredito>
                <ns1:codCuentaHabiente>{ data($transferenciaCuentasRequest/CREDIT_ACCOUNT) }</ns1:codCuentaHabiente>
            </ns1:cuentaCredito>
            <ns1:montoTranferencia>{ data($transferenciaCuentasRequest/TRANSFER_AMOUNT) }</ns1:montoTranferencia>
            <ns1:monedaOperacion>
                {
                    for $CURRENCY in $transferenciaCuentasRequest/CURRENCY
                    return
                        <ns1:valSimboloMoneda>{ data($CURRENCY) }</ns1:valSimboloMoneda>
                }
            </ns1:monedaOperacion>
            {
                for $DESCRIPTION in $transferenciaCuentasRequest/DESCRIPTION
                return
                    <ns1:descripcion>{ data($DESCRIPTION) }</ns1:descripcion>
            }
            {
                let $__nullable := ( if (data($transferenciaCuentasRequest/AUTHORIZATION_TICKET) != '') then
                                         (xs:decimal($transferenciaCuentasRequest/AUTHORIZATION_TICKET))
                                     else 
                                         () )
                return
                    if (fn:boolean($__nullable))
                    then
                        <ns1:numTicket>{ $__nullable }</ns1:numTicket>
                    else
                        ()
            }
        </ns2:opTransferenciaCuentaSolicitud>
};

declare variable $transferenciaCuentasRequest as element(ns0:transferenciaCuentasRequest) external;

xf:transferenciaCuentasNIIn($transferenciaCuentasRequest)