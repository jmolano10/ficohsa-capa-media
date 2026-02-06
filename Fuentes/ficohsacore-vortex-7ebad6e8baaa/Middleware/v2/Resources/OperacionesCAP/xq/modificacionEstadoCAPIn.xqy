xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$modificacionEstadoCAPRequest" element="ns1:modificacionEstadoCAPRequest" location="../xsd/operacionesCAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ModificacionEstadoCAP/xsd/modificacionEstadoCAP_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/modificacionEstadoCAP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/modificacionEstadoCAPIn/";

declare function xf:modificacionEstadoCAPIn($modificacionEstadoCAPRequest as element(ns1:modificacionEstadoCAPRequest),
    $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGO_PAIS>{ $codigoPais }</ns0:PV_CODIGO_PAIS>
            <ns0:PN_ID_CAP>{ data($modificacionEstadoCAPRequest/ID_CAP) }</ns0:PN_ID_CAP>
            <ns0:PV_ESTADO>{ data($modificacionEstadoCAPRequest/ESTADO) }</ns0:PV_ESTADO>
            <ns0:PV_OFICIAL_MODIFICACION>{ data($modificacionEstadoCAPRequest/OFICIAL_MODIFICACION) }</ns0:PV_OFICIAL_MODIFICACION>
            <ns0:PV_OFICIAL_AUTORIZADOR_MODIFICADOR>{ data($modificacionEstadoCAPRequest/OFICIAL_AUTORIZADOR_MODIFICADOR) }</ns0:PV_OFICIAL_AUTORIZADOR_MODIFICADOR>
        </ns0:InputParameters>
};

declare variable $modificacionEstadoCAPRequest as element(ns1:modificacionEstadoCAPRequest) external;
declare variable $codigoPais as xs:string external;

xf:modificacionEstadoCAPIn($modificacionEstadoCAPRequest,
    $codigoPais)