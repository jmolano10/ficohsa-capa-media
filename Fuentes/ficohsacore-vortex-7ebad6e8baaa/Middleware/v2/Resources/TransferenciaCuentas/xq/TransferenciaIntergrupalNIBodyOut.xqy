xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opTransferenciaRegionalRespuesta" element="ns3:opTransferenciaRegionalRespuesta" location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:transferenciaCuentasResponse" location="../xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/TransferenciaIntergrupalNIOut/";

declare function xf:TransferenciaIntergrupalNIOut($opTransferenciaRegionalRespuesta as element(ns3:opTransferenciaRegionalRespuesta))
    as element(ns0:transferenciaCuentasResponse) {
        <ns0:transferenciaCuentasResponse>
            {
                for $ctaDebito in $opTransferenciaRegionalRespuesta/ns1:transferenciaRegional/ns1:ctaDebito
                return
                    <DEBIT_ACCOUNT>{ data($ctaDebito) }</DEBIT_ACCOUNT>
            }
            {
                for $ctaCredito in $opTransferenciaRegionalRespuesta/ns1:transferenciaRegional/ns1:ctaCredito
                return
                    <CREDIT_ACCOUNT>{ data($ctaCredito) }</CREDIT_ACCOUNT>
            }
            {
                for $depositante in $opTransferenciaRegionalRespuesta/ns1:transferenciaRegional/ns1:depositante
                return
                    <DEBIT_CUSTOMER>{ data($depositante) }</DEBIT_CUSTOMER>
            }
            {
                for $beneficiario in $opTransferenciaRegionalRespuesta/ns1:transferenciaRegional/ns1:beneficiario
                return
                    <CREDIT_CUSTOMER>{ data($beneficiario) }</CREDIT_CUSTOMER>
            }
            {
                for $monedaCtaOrigen in $opTransferenciaRegionalRespuesta/ns1:transferenciaRegional/ns1:monedaCtaOrigen
                return
                    <DEBIT_CURRENCY>{ data($monedaCtaOrigen) }</DEBIT_CURRENCY>
            }
            {
                for $monedaCtaDestino in $opTransferenciaRegionalRespuesta/ns1:transferenciaRegional/ns1:monedaCtaDestino
                return
                    <CREDIT_CURRENCY>{ data($monedaCtaDestino) }</CREDIT_CURRENCY>
            }
            <DEBIT_AMOUNT>{ data($opTransferenciaRegionalRespuesta/ns1:transferenciaRegional/ns1:valorCtaOrigen) }</DEBIT_AMOUNT>
            <CREDIT_AMOUNT>{ data($opTransferenciaRegionalRespuesta/ns1:transferenciaRegional/ns1:valorCtaDestino) }</CREDIT_AMOUNT>
            <EXCHANGE_RATE>{ data($opTransferenciaRegionalRespuesta/ns1:transferenciaRegional/ns1:tipoCambio) }</EXCHANGE_RATE>
            {
                for $fechaAplicacion in $opTransferenciaRegionalRespuesta/ns1:transferenciaRegional/ns1:fechaAplicacion
                return
                    <DATE_TIME>{ data($fechaAplicacion) }</DATE_TIME>
            }
            {
                for $PV_COMISION in $opTransferenciaRegionalRespuesta/ns1:transferenciaRegional/ns1:comision
                return
                    <COMMISSION>{ data($PV_COMISION) }</COMMISSION>
            }
            <INTERNATIONAL_ACCOUNT_NUMBER_DEBIT_ACCOUNT></INTERNATIONAL_ACCOUNT_NUMBER_DEBIT_ACCOUNT>
            <INTERNATIONAL_ACCOUNT_NUMBER_CREDIT_ACCOUNT></INTERNATIONAL_ACCOUNT_NUMBER_CREDIT_ACCOUNT>            
        </ns0:transferenciaCuentasResponse>
};

declare variable $opTransferenciaRegionalRespuesta as element(ns3:opTransferenciaRegionalRespuesta) external;

xf:TransferenciaIntergrupalNIOut($opTransferenciaRegionalRespuesta)