xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opBuscarCertificadoDPFRespuesta1" element="ns1:opBuscarCertificadoDPFRespuesta" location="../../../BusinessServices/CTS/deposito/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaCertificadoDepositoResponse" location="../../../../Business_Resources/consultaCertificadoDeposito/consultaCertificadoDeposito/consultaCertificadoDepositoTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaCertificadoDepositoTypes";
declare namespace ns1 = "http://service.srvaplcobiscertificadodeposito.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCertificadoDeposito/xq/consultaCDNIOut/";

declare function xf:consultaCDNIOut($opBuscarCertificadoDPFRespuesta1 as element(ns1:opBuscarCertificadoDPFRespuesta))
    as element(ns2:consultaCertificadoDepositoResponse) {
        <ns2:consultaCertificadoDepositoResponse>
            <ns2:consultaCertificadoDepositoResponseType>
                <ns2:consultaCertificadoDepositoResponseRecordType>
                    {
                        for $clienteDepositante in $opBuscarCertificadoDPFRespuesta1/ns0:cdt/ns0:clienteDepositante
                        return
                            <DEPOSIT_NAME>{ fn:replace(data($clienteDepositante),"[Ññ]", "#") }</DEPOSIT_NAME>
                    }
                    {
                        for $codTipoCDT in $opBuscarCertificadoDPFRespuesta1/ns0:cdt/ns0:codTipoCDT
                        return
                            <DEPOSIT_TYPE>{ data($codTipoCDT) }</DEPOSIT_TYPE>
                    }
                    <EFFECTIVE_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($opBuscarCertificadoDPFRespuesta1/ns0:cdt/ns0:fecApertura)) }</EFFECTIVE_DATE>
                    <MATURITY_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($opBuscarCertificadoDPFRespuesta1/ns0:cdt/ns0:fecVencimiento)) }</MATURITY_DATE>
                    <DEPOSIT_TERM>{ data($opBuscarCertificadoDPFRespuesta1/ns0:cdt/ns0:valPlazo) }</DEPOSIT_TERM>
                    <INTEREST_RATE>{ data($opBuscarCertificadoDPFRespuesta1/ns0:cdt/ns0:valTasa) }</INTEREST_RATE>
                    <PRINCIPAL_AMOUNT>{ fn:round-half-to-even(xs:decimal(data($opBuscarCertificadoDPFRespuesta1/ns0:cdt/ns0:valMonto)),2) }</PRINCIPAL_AMOUNT>
                    <INTEREST_AMOUNT>{ fn:round-half-to-even(xs:decimal(data($opBuscarCertificadoDPFRespuesta1/ns0:cdt/ns0:valInteresDevengado)),2) }</INTEREST_AMOUNT>
                    {
			        	if(data($opBuscarCertificadoDPFRespuesta1/ns0:cdt/ns0:valEstado) = 1
			        	)  then (       
				    		<LOCKED_YES_NO>YES</LOCKED_YES_NO>
				        )
				        else(
				        	<LOCKED_YES_NO>NO</LOCKED_YES_NO>
				        )
				    }
                    {
                        for $codTipoMoneda in $opBuscarCertificadoDPFRespuesta1/ns0:cdt/ns0:moneda/ns0:codTipoMoneda
                        return
                            <CURRENCY>{ data($codTipoMoneda) }</CURRENCY>
                    }
                </ns2:consultaCertificadoDepositoResponseRecordType>
            </ns2:consultaCertificadoDepositoResponseType>
        </ns2:consultaCertificadoDepositoResponse>
};

declare variable $opBuscarCertificadoDPFRespuesta1 as element(ns1:opBuscarCertificadoDPFRespuesta) external;

xf:consultaCDNIOut($opBuscarCertificadoDPFRespuesta1)