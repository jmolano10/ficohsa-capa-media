(:: pragma bea:global-element-parameter parameter="$opConsultaDGIRespuesta" element="ns3:opConsultaDGIRespuesta" location="../../../BusinessServices/CTS/impuesto/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDGIResponse" location="../xsd/consultaDGITypes.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDGITypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDGI/xq/consultaDGIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobisimpuestos.ecobis.cobiscorp";

declare function xf:consultaDGIOut($opConsultaDGIRespuesta as element(ns3:opConsultaDGIRespuesta))
    as element(ns1:consultaDGIResponse) {
        <ns1:consultaDGIResponse>
            {
                for $valMontoBit in $opConsultaDGIRespuesta/ns0:datosBITN900/ns0:valMontoBit
                return
                    <TOTAL_AMOUNT>{ data($valMontoBit) }</TOTAL_AMOUNT>
            }
            {
                for $fechaVencimiento in $opConsultaDGIRespuesta/ns0:datosBITN900/ns0:fechaVencimiento
                return
                    <DUE_DATE>{ fn:adjust-date-to-timezone(fn-bea:date-from-dateTime(data($fechaVencimiento)),()) }</DUE_DATE>
            }
            {
                for $valImpuesto in $opConsultaDGIRespuesta/ns0:datosBITN900/ns0:valImpuesto
                return
                    <TAX_VALUE>{ data($valImpuesto) }</TAX_VALUE>
            }
            {
                for $valMontoMantenimiento in $opConsultaDGIRespuesta/ns0:datosBITN900/ns0:valMontoMantenimiento
                return
                    <EXCH_RATE_FEE>{ data($valMontoMantenimiento) }</EXCH_RATE_FEE>
            }
            {
                for $valMora in $opConsultaDGIRespuesta/ns0:datosBITN900/ns0:valMora
                return
                    <LATE_FEE>{ data($valMora) }</LATE_FEE>
            }
            {
                for $valMulta in $opConsultaDGIRespuesta/ns0:datosBITN900/ns0:valMulta
                return
                    <PENALTY_FEE>{ data($valMulta) }</PENALTY_FEE>
            }
            {
                for $valMontoBit in $opConsultaDGIRespuesta/ns0:datosBITN900/ns0:valMontoBit
                return
                    <BILL_AMOUNT>{ data($valMontoBit) }</BILL_AMOUNT>
            }
            {
                for $codigoCuenta in $opConsultaDGIRespuesta/ns0:datosBITN900/ns0:codigoCuenta
                return
                    <ACCOUNT_CODE>{ data($codigoCuenta) }</ACCOUNT_CODE>
            }
            {
                for $descripcionImpuesto in $opConsultaDGIRespuesta/ns0:datosBITN900/ns0:descripcionImpuesto
                return
                    <TAX_DESCRIPTION>{ data($descripcionImpuesto) }</TAX_DESCRIPTION>
            }
        </ns1:consultaDGIResponse>
};

declare variable $opConsultaDGIRespuesta as element(ns3:opConsultaDGIRespuesta) external;

xf:consultaDGIOut($opConsultaDGIRespuesta)
