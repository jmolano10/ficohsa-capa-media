(:: pragma bea:global-element-parameter parameter="$opBuscarPaisesRespuesta" element="ns2:opBuscarPaisesRespuesta" location="../../../BusinessServices/CTS/generalService/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaPaisesResponse" location="../../../../Business_Resources/direcciones/consultaPaises/consultaPaisesTypes.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobisgenerales.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaPaisesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPaises/xq/consultaPaisesNIOut/";

declare function xf:consultaPaisesNIOut($opBuscarPaisesRespuesta as element(ns2:opBuscarPaisesRespuesta))
    as element(ns1:consultaPaisesResponse) {
        <ns1:consultaPaisesResponse>
            <ns1:consultaPaisesResponseType>
            {
            	let $codPais := $opBuscarPaisesRespuesta/ns0:pais/ns0:codPais
            	let $valPais := $opBuscarPaisesRespuesta/ns0:pais/ns0:valPais
            	for $i in 1 to count($codPais)
            	return
                	<ns1:consultaPaisesResponseRecordType>
                		<COUNTRY_CODE>{ data($codPais[$i]) }</COUNTRY_CODE>
                		<COUNTRY_NAME>{ data($valPais[$i]) }</COUNTRY_NAME>
                	</ns1:consultaPaisesResponseRecordType>
            }
            </ns1:consultaPaisesResponseType>
        </ns1:consultaPaisesResponse>
};

declare variable $opBuscarPaisesRespuesta as element(ns2:opBuscarPaisesRespuesta) external;

xf:consultaPaisesNIOut($opBuscarPaisesRespuesta)