xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoderemesaconcredacuentaResponse" element="ns0:PagoderemesaconcredacuentaResponse" location="../Resoruces/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../Resoruces/ObtenerCodigoError/xsd/MIDDLEWARE_CONSULTAR_CODIGO_ERROR.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/MIDDLEWARE/CONSULTAR_CODIGO_ERROR/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/PagoRemesaCreditoCuenta/ObtenerCodigoError/";

declare function xf:ObtenerCodigoError($pagoderemesaconcredacuentaResponse as element(ns0:PagoderemesaconcredacuentaResponse),
    $contrato as xs:string,
    $indicador as xs:string,
    $mensaje as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:VA_CONTRATO>{ $contrato }</ns1:VA_CONTRATO>
            {
                    if ($indicador = "ErrorRemesa") then (
                    let $messages := $pagoderemesaconcredacuentaResponse/Status/messages
                    return
                        <ns1:VA_MENSAJE_ERROR>{ data($messages[1]) }</ns1:VA_MENSAJE_ERROR>
                    )else(
                    	<ns1:VA_MENSAJE_ERROR>{ data($mensaje) }</ns1:VA_MENSAJE_ERROR>
                    )
            }
        </ns1:InputParameters>
};

declare variable $pagoderemesaconcredacuentaResponse as element(ns0:PagoderemesaconcredacuentaResponse) external;
declare variable $contrato as xs:string external;
declare variable $indicador as xs:string external;
declare variable $mensaje as xs:string external;

xf:ObtenerCodigoError($pagoderemesaconcredacuentaResponse,
    $contrato,
    $indicador,
    $mensaje)