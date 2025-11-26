(:: pragma bea:global-element-parameter parameter="$sjConsultaActivosPasivosClienteIN" element="ns0:sjConsultaActivosPasivosCliente" location="../xsd/sjConsultaActivosPasivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RequestHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosPasivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaActivosPasivosCliente/xq/ConsultaActivosPasivosClienteHeaderIN/";

declare function xf:ConsultaActivosPasivosClienteHeaderIN($sjConsultaActivosPasivosClienteIN as element(ns0:sjConsultaActivosPasivosCliente))
    as element(ns1:RequestHeader) {
        <ns1:RequestHeader>
            <Authentication>
                <UserName>{ data($sjConsultaActivosPasivosClienteIN/ns0:USERNAME) }</UserName>
                <Password>{ data($sjConsultaActivosPasivosClienteIN/ns0:PASSWORD) }</Password>
            </Authentication>
            <Region>
                <SourceBank>{ data($sjConsultaActivosPasivosClienteIN/ns0:SOURCE_BANK) }</SourceBank>
               {
                if (data($sjConsultaActivosPasivosClienteIN/ns0:DESTINATION_BANK/text())!='' ) then ( 
                <DestinationBank>{ data($sjConsultaActivosPasivosClienteIN/ns0:DESTINATION_BANK) }</DestinationBank>
                )else()
                }
            </Region>
        </ns1:RequestHeader>
};

declare variable $sjConsultaActivosPasivosClienteIN as element(ns0:sjConsultaActivosPasivosCliente) external;

xf:ConsultaActivosPasivosClienteHeaderIN($sjConsultaActivosPasivosClienteIN)
