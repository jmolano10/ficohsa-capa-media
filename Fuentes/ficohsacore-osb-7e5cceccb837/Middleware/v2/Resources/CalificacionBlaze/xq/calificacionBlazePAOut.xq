(:: pragma bea:global-element-parameter parameter="$originacionesPAResponse" element="ns1:OriginacionesPAResponse" location="../../../BusinessServices/BLAZEPA/xsd/XMLSchema_-722978153.xsd" ::)
(:: pragma bea:global-element-return element="ns0:calificacionBlazeResponse" location="../../GestionesSolicitudCredito/xsd/gestionesSolicitudCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesSolicitudCreditoTypes";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/Business.Entities.PA";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CalificacionBlaze/xq/calificacionBlazePAOut/";
declare namespace ns3 = "http://schemas.datacontract.org/2004/07/Core.Entities";

declare function xf:calificacionBlazePAOut($originacionesPAResponse as element(ns1:OriginacionesPAResponse))
    as element(ns0:calificacionBlazeResponse) {
        <ns0:calificacionBlazeResponse>
            {
                for $NoTicket in $originacionesPAResponse/ns1:OriginacionesPAResult/ns2:SolicitanteOut/ns2:NoTicket
                return
                    <TICKET_NUMBER>{ data($NoTicket) }</TICKET_NUMBER>
            }
        </ns0:calificacionBlazeResponse>
};

declare variable $originacionesPAResponse as element(ns1:OriginacionesPAResponse) external;

xf:calificacionBlazePAOut($originacionesPAResponse)