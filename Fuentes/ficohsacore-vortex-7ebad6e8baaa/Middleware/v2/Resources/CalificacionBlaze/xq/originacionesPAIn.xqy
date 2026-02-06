xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$calificacionBlaze" element="ns0:calificacionBlaze" location="../../GestionesSolicitudCredito/xsd/gestionesSolicitudCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:OriginacionesPA" location="../../../BusinessServices/BLAZEPA/xsd/XMLSchema_-722978153.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesSolicitudCreditoTypes";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/Business.Entities.PA";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CalificacionBlaze/xq/originacionesPAIn/";
declare namespace ns3 = "http://schemas.datacontract.org/2004/07/Core.Entities";

declare function xf:originacionesPAIn($calificacionBlaze as element(ns0:calificacionBlaze))
    as element(ns1:OriginacionesPA) {
        <ns1:OriginacionesPA>
            <ns1:request>
                <ns2:MensajeEntradaInfo>
                    <ns3:Pais>{ data($calificacionBlaze/COMPANY) }</ns3:Pais>
                </ns2:MensajeEntradaInfo>
                <ns2:SolicitanteIn>
                    <ns2:AntVivienda>{ data($calificacionBlaze/TENEMENT_TIME) }</ns2:AntVivienda>
                    <ns2:Campana>{ data($calificacionBlaze/CAMPAIGN) }</ns2:Campana>
                    <ns2:CodResultadoUltimaSolicitud>{ data($calificacionBlaze/REQUEST_LAST_RESULT) }</ns2:CodResultadoUltimaSolicitud>
                    <ns2:EtapaSolicitud>{ data($calificacionBlaze/REQUEST_STAGE) }</ns2:EtapaSolicitud>
                    <ns2:FechaIngresoEmpleo>{ fn-bea:dateTime-from-string-with-format("yyyyMMdd", data($calificacionBlaze/JOB_START_DATE)) }</ns2:FechaIngresoEmpleo>
                    <ns2:FechaNacimiento>{ fn-bea:dateTime-from-string-with-format("yyyyMMdd", data($calificacionBlaze/BIRTH_DATE)) }</ns2:FechaNacimiento>
                    <ns2:FechaUltimaSolicitud>{ fn-bea:dateTime-from-string-with-format("yyyyMMdd", data($calificacionBlaze/REQUEST_LAST_DATE)) }</ns2:FechaUltimaSolicitud>
                    <ns2:Identidad>{ data($calificacionBlaze/ID_VALUE) }</ns2:Identidad>
                    <ns2:Ingreso>{ data($calificacionBlaze/INCOME) }</ns2:Ingreso>
                    <ns2:NumeroSolicitud>{ data($calificacionBlaze/REQUEST_NUMBER) }</ns2:NumeroSolicitud>
                    <ns2:PerfilCliente>{ data($calificacionBlaze/CUSTOMER_PROFILE) }</ns2:PerfilCliente>
                    <ns2:TipoIdentidad>{ data($calificacionBlaze/ID_TYPE) }</ns2:TipoIdentidad>
                    <ns2:TipoSolicitud>{ data($calificacionBlaze/REQUEST_TYPE) }</ns2:TipoSolicitud>
                    <ns2:TipoVivienda>{ data($calificacionBlaze/TENEMENT_TYPE) }</ns2:TipoVivienda>
                </ns2:SolicitanteIn>
            </ns1:request>
        </ns1:OriginacionesPA>
};

declare variable $calificacionBlaze as element(ns0:calificacionBlaze) external;

xf:originacionesPAIn($calificacionBlaze)