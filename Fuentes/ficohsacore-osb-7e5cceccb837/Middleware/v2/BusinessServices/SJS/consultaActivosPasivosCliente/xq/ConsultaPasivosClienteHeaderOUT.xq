(:: pragma bea:global-element-parameter parameter="$responseHeaderIN" element="ns1:ResponseHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaActivosPasivosClienteResponse" location="../xsd/sjConsultaActivosPasivosCliente.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosPasivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaActivosPasivosCliente/xq/ConsultaPasivosClienteHeaderOUT/";

declare function xf:ConsultaPasivosClienteHeaderOUT($responseHeaderIN as element(ns1:ResponseHeader))
    as element(ns0:sjConsultaActivosPasivosClienteResponse) {
        <ns0:sjConsultaActivosPasivosClienteResponse>
            <ns0:LIABILITIES_STATUS>
               <ns0:STATUS>
                {
                    for $successIndicator in $responseHeaderIN/successIndicator
                    return
                        <ns0:SUCCESS_INDICATOR>{ data($successIndicator) }</ns0:SUCCESS_INDICATOR>
                }
                {
                 if(upper-case(data($responseHeaderIN/successIndicator/text()))!='SUCCESS') then(
                     <ns0:ERROR_MESSAGE>{ $responseHeaderIN/messages/text() }</ns0:ERROR_MESSAGE>
                 )else()
                }
               </ns0:STATUS>
            </ns0:LIABILITIES_STATUS>
        </ns0:sjConsultaActivosPasivosClienteResponse>
};

declare variable $responseHeaderIN as element(ns1:ResponseHeader) external;

xf:ConsultaPasivosClienteHeaderOUT($responseHeaderIN)
