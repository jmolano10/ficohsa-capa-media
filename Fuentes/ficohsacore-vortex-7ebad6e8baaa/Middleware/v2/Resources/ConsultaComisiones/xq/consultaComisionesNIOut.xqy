xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaComisionesRespuesta" element="ns1:opConsultaComisionesRespuesta" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaComisionesResponse" location="../xsd/consultaComisionesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns1 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";

declare function xf:consultaComisionesNIOut($opConsultaComisionesRespuesta as element(ns1:opConsultaComisionesRespuesta))
    as element(ns0:consultaComisionesResponse) {
        <ns0:consultaComisionesResponse>
            {
                for $valSimboloMoneda in $opConsultaComisionesRespuesta/ns2:moneda/ns2:valSimboloMoneda
                return
                    <CURRENCY>{ data($valSimboloMoneda) }</CURRENCY>
            }
            <AMOUNT>{ data($opConsultaComisionesRespuesta/ns2:monto) }</AMOUNT>
        </ns0:consultaComisionesResponse>
};

declare variable $opConsultaComisionesRespuesta as element(ns1:opConsultaComisionesRespuesta) external;

xf:consultaComisionesNIOut($opConsultaComisionesRespuesta)