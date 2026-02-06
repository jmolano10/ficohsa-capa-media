xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$inscripcionesRENAP" element="ns0:inscripcionesRENAP" location="../../InscripcionesRENAP/xsd/inscripcionesRENAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/RENAP/registraErrorRenap/xsd/registraErrorRenap_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/inscripcionesRENAPTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraErrorRenap";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/InscripcionesRENAPGT/xq/registraErrorRenapGTIn/";

declare function xf:registraErrorRenapGTIn($inscripcionesRENAP as element(ns0:inscripcionesRENAP),
    $errorMessage as xs:string,
    $request as xs:string,
    $response as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CUI>{ data($inscripcionesRENAP/CUI) }</ns1:PV_CUI>
            <ns1:PV_TIPO_CONSULTA>{ data($inscripcionesRENAP/QUERY_TYPE) }</ns1:PV_TIPO_CONSULTA>
            <ns1:PV_ORIGEN_CONSULTA>{ data($inscripcionesRENAP/ORIGIN_INQUIRY) }</ns1:PV_ORIGEN_CONSULTA>
            <ns1:PV_DESC_ERROR>{ $errorMessage }</ns1:PV_DESC_ERROR>
            <ns1:PCL_REQUEST>{ $request }</ns1:PCL_REQUEST>
            <ns1:PCL_RESPONSE>{ $response }</ns1:PCL_RESPONSE>
        </ns1:InputParameters>
};

declare variable $inscripcionesRENAP as element(ns0:inscripcionesRENAP) external;
declare variable $errorMessage as xs:string external;
declare variable $request as xs:string external;
declare variable $response as xs:string external;

xf:registraErrorRenapGTIn($inscripcionesRENAP,
    $errorMessage,
    $request,
    $response)