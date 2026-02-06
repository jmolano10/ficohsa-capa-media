xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaComisionesRespuesta" element="ns1:opConsultaComisionesRespuesta" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMontoTipoChequeraResponse" location="../xsd/consultaMontoTipoChequeraTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTipoChequeraTypes";
declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns1 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMontoTipoChequera/xq/consultaMontoTipoChequeraNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";

declare function xf:consultaMontoTipoChequeraNIOut($opConsultaComisionesRespuesta as element(ns1:opConsultaComisionesRespuesta))
    as element(ns0:consultaMontoTipoChequeraResponse) {
        <ns0:consultaMontoTipoChequeraResponse>
            {
                for $valSimboloMoneda in $opConsultaComisionesRespuesta/ns2:moneda/ns2:valSimboloMoneda
                return
                    <CHARGE_CURRENCY>{ data($valSimboloMoneda) }</CHARGE_CURRENCY>
            }
            <CHARGE_AMOUNT>{ data($opConsultaComisionesRespuesta/ns2:monto) }</CHARGE_AMOUNT>
        </ns0:consultaMontoTipoChequeraResponse>
};

declare variable $opConsultaComisionesRespuesta as element(ns1:opConsultaComisionesRespuesta) external;

xf:consultaMontoTipoChequeraNIOut($opConsultaComisionesRespuesta)