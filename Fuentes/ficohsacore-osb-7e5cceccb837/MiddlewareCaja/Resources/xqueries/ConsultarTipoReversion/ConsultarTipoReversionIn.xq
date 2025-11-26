(:: pragma bea:global-element-parameter parameter="$consultarTipoReversion" element="ns0:consultarTipoReversion" location="../../xsds/ConsultarTipoReversion/ConsultarTipoReversion.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/ConsultarTipoReversion/consultarTipoReversionT24/MIDDLEWARE_OSB_CONSULTAR_TIPO_REVERSION.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/MIDDLEWARE/OSB_CONSULTAR_TIPO_REVERSION/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultarTipoReversionTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultarTipoReversion/ConsultarTipoReversionIn/";

declare function xf:ConsultarTipoReversionIn($consultarTipoReversion as element(ns0:consultarTipoReversion))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $REVERSAL_TYPE in $consultarTipoReversion/REVERSAL_TYPE
                return
                    <ns1:TIPO_REVERSION_CONS>{ data($REVERSAL_TYPE) }</ns1:TIPO_REVERSION_CONS>
            }
        </ns1:InputParameters>
};

declare variable $consultarTipoReversion as element(ns0:consultarTipoReversion) external;

xf:ConsultarTipoReversionIn($consultarTipoReversion)