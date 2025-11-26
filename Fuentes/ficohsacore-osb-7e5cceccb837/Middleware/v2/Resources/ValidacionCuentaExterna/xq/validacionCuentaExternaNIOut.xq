(:: pragma bea:global-element-parameter parameter="$validacionCuentaExterna" element="ns2:validacionCuentaExterna" location="../xsd/validacionCuentaExternaTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$opConsultaProductoRespuesta" element="ns3:opConsultaProductoRespuesta" location="../../../BusinessServices/CTS/ValidacionCuentaExterna/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns2:validacionCuentaExternaResponse" location="../xsd/validacionCuentaExternaTypes.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisachsaliente.ecobis.cobiscorp";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaExternaTypes";
declare namespace ns1 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionCuentaExterna/xq/validacionCuentaExternaNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobisachsaliente.ecobis.cobiscorp";

declare function xf:validacionCuentaExternaNIOut($validacionCuentaExterna as element(ns2:validacionCuentaExterna),
    $opConsultaProductoRespuesta as element(ns3:opConsultaProductoRespuesta))
    as element(ns2:validacionCuentaExternaResponse) {
        <ns2:validacionCuentaExternaResponse>
            <ACCOUNT_NUMBER>{ data($validacionCuentaExterna/ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            {
                for $ACCOUNT_NAME in $validacionCuentaExterna/ACCOUNT_NAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNT_NAME) }</ACCOUNT_NAME>
            }
            <CURRENCY>{ data($validacionCuentaExterna/ACCOUNT_CURRENCY) }</CURRENCY>
            {
                for $status in $opConsultaProductoRespuesta/ns0:responseACHSaliente/ns0:status
                return
                    <ACCOUNT_STATUS>{ data($status) }</ACCOUNT_STATUS>
            }
            <PRODUCT_TYPE>{ data($validacionCuentaExterna/PRODUCT_TYPE) }</PRODUCT_TYPE>
        </ns2:validacionCuentaExternaResponse>
};

declare variable $validacionCuentaExterna as element(ns2:validacionCuentaExterna) external;
declare variable $opConsultaProductoRespuesta as element(ns3:opConsultaProductoRespuesta) external;

xf:validacionCuentaExternaNIOut($validacionCuentaExterna,
    $opConsultaProductoRespuesta)
