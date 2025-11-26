(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuentaRep" element="ns1:consultaMovimientosCuentaRep" location="../xsd/ConsultaMovimientosCuentaRep.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opConsultaMovimientoCuentaSolicitud" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)

declare namespace ns2 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ConsultaMovimientosCuentaRepType";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuentaRep/xq/consultaMovimientosCuentaRepNIIn/";

declare function convertirFecha($date as xs:string) 
    as xs:dateTime {
        fn-bea:dateTime-from-string-with-format("yyyyMMdd",$date)
};

declare function xf:consultaMovimientosCuentaRepNIIn
	(
	    $BEGIN_DATE as xs:string,
	    $END_DATE as xs:string,
	    $consultaMovimientosCuentaRep as element(ns1:consultaMovimientosCuentaRep)
    )
    as element(ns2:opConsultaMovimientoCuentaSolicitud) {
        <ns2:opConsultaMovimientoCuentaSolicitud>
            <ns0:valNumCuenta>
                <ns0:codCuentaHabiente>{ data($consultaMovimientosCuentaRep/ACCOUNT_NUMBER) }</ns0:codCuentaHabiente>
            </ns0:valNumCuenta>
            <ns0:valFecInicio>
                {
                    if ($BEGIN_DATE != '') then
                        (convertirFecha(data($BEGIN_DATE)))
                    else 
                        ()
                }
</ns0:valFecInicio>
            <ns0:valFecFin>
                {
                    if ($END_DATE != '') then
                        (convertirFecha(data($END_DATE)))
                    else 
                        ()
                }
</ns0:valFecFin>
        </ns2:opConsultaMovimientoCuentaSolicitud>
};

declare variable $BEGIN_DATE as xs:string external;
declare variable $END_DATE as xs:string external;
declare variable $consultaMovimientosCuentaRep as element(ns1:consultaMovimientosCuentaRep) external;

xf:consultaMovimientosCuentaRepNIIn
(
    $BEGIN_DATE,
    $END_DATE,
    $consultaMovimientosCuentaRep
)
