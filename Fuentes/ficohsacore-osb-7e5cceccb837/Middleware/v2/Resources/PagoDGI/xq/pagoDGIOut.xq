(:: pragma bea:global-element-parameter parameter="$opPagoDGIRespuesta" element="ns3:opPagoDGIRespuesta" location="../../../BusinessServices/CTS/impuesto/xsd/services.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoDGIRequest" element="ns0:pagoDGIRequest" location="../xsd/pagoDGITypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoDGIResponse" location="../xsd/pagoDGITypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoDGITypes";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoDGI/xq/pagoDGIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobisimpuestos.ecobis.cobiscorp";

declare function xf:pagoDGIOut($opPagoDGIRespuesta as element(ns3:opPagoDGIRespuesta),
    $pagoDGIRequest as element(ns0:pagoDGIRequest))
    as element(ns0:pagoDGIResponse) {
        <ns0:pagoDGIResponse>
            <TOTAL_AMOUNT>{ data($pagoDGIRequest/TOTAL_AMOUNT) }</TOTAL_AMOUNT>
            <DUE_DATE>{ data($pagoDGIRequest/DUE_DATE) }</DUE_DATE>
            {
                for $valImpuesto in $opPagoDGIRespuesta/ns1:datosPagN900Respuesta/ns1:valImpuesto
                return
                    <TAX_VALUE>{ data($valImpuesto) }</TAX_VALUE>
            }
            {
                for $valMontoMantenimiento in $opPagoDGIRespuesta/ns1:datosPagN900Respuesta/ns1:valMontoMantenimiento
                return
                    <EXCH_RATE_FEE>{ data($valMontoMantenimiento) }</EXCH_RATE_FEE>
            }
            {
                for $valMora in $opPagoDGIRespuesta/ns1:datosPagN900Respuesta/ns1:valMora
                return
                    <LATE_FEE>{ data($valMora) }</LATE_FEE>
            }
            {
                for $valMulta in $opPagoDGIRespuesta/ns1:datosPagN900Respuesta/ns1:valMulta
                return
                    <PENALTY_FEE>{ data($valMulta) }</PENALTY_FEE>
            }
            <BILL_AMOUNT>{ round-half-to-even(data($pagoDGIRequest/PAYMENT_AMOUNT), 2) }</BILL_AMOUNT>
            {
                for $sif in $opPagoDGIRespuesta/ns1:detallePagoDGI/ns1:sif
                return
                    <SIF_CODE>{ data($sif) }</SIF_CODE>
            }
        </ns0:pagoDGIResponse>
};

declare variable $opPagoDGIRespuesta as element(ns3:opPagoDGIRespuesta) external;
declare variable $pagoDGIRequest as element(ns0:pagoDGIRequest) external;

xf:pagoDGIOut($opPagoDGIRespuesta,
    $pagoDGIRequest)
