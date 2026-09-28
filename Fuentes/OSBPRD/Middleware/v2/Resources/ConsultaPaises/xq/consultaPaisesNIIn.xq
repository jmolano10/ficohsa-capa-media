(:: pragma bea:global-element-parameter parameter="$consultaPaises" element="ns1:consultaPaises" location="../../../../Business_Resources/direcciones/consultaPaises/consultaPaisesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opBuscarPaisesSolicitud" location="../../../BusinessServices/CTS/generalService/xsd/services.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobisgenerales.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaPaisesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPaises/xq/consultaPaisesNIIn/";

declare function xf:consultaPaisesNIIn($consultaPaises as element(ns1:consultaPaises))
    as element(ns2:opBuscarPaisesSolicitud) {
        <ns2:opBuscarPaisesSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>               
            <ns0:pais>
                {
                    for $COUNTRY_CODE in $consultaPaises/COUNTRY_CODE
                    return
                        <ns0:codPais>{ data($COUNTRY_CODE) }</ns0:codPais>
                }
            </ns0:pais>
        </ns2:opBuscarPaisesSolicitud>
};

declare variable $consultaPaises as element(ns1:consultaPaises) external;

xf:consultaPaisesNIIn($consultaPaises)