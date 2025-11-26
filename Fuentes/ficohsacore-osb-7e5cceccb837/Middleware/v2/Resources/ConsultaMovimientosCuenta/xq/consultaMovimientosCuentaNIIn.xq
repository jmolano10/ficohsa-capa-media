(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuenta" element="ns0:consultaMovimientosCuenta" location="../xsd/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:opConsultaMovimientoCuentaSolicitud" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns1 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuenta/xq/consultaMovimientosCuentaNIIn/";

declare function convertirFecha($date as xs:string) 
    as xs:dateTime {
        fn-bea:dateTime-from-string-with-format("yyyyMMdd",$date)
};

declare function xf:consultaMovimientosCuentaNIIn($consultaMovimientosCuenta as element(ns0:consultaMovimientosCuenta),
    $BEGIN_DATE as xs:string,
    $END_DATE as xs:string)
    as element(ns1:opConsultaMovimientoCuentaSolicitud) {
        <ns1:opConsultaMovimientoCuentaSolicitud>
        	<ns2:contextoTransaccional>
                <ns2:codCanalOriginador>1</ns2:codCanalOriginador>
            </ns2:contextoTransaccional>
            <ns2:valNumCuenta>
                <ns2:codCuentaHabiente>{ data($consultaMovimientosCuenta/ACCOUNT_NUMBER) }</ns2:codCuentaHabiente>
            </ns2:valNumCuenta>
            <ns2:valFecInicio>
                {
                    if ($BEGIN_DATE != '') then
                        (convertirFecha(data($BEGIN_DATE)))
                    else 
                        ()
                }
			</ns2:valFecInicio>
            <ns2:valFecFin>
                {
                    if ($END_DATE != '') then
                        (convertirFecha(data($END_DATE)))
                    else 
                        ()
                }
			</ns2:valFecFin>
            <ns2:paginacion>
                
                { 
	            	if (data($consultaMovimientosCuenta/PAGING_INFO/PAGING/text()) = "YES") then
	            		<ns2:valUltimoRegistroEntero>{ xs:int(data($consultaMovimientosCuenta/PAGING_INFO/INITIAL_RECORD)) - 1}</ns2:valUltimoRegistroEntero>
	            	else
	            		""
	            }
                
                { 
	            	if (data($consultaMovimientosCuenta/PAGING_INFO/PAGING/text()) = "YES") then
	            		<ns2:valTamPagina>{ data($consultaMovimientosCuenta/PAGING_INFO/RECORD_COUNT) }</ns2:valTamPagina>
	            	else
	            		("")
	            }
                
            </ns2:paginacion>
        </ns1:opConsultaMovimientoCuentaSolicitud>
};

declare variable $consultaMovimientosCuenta as element(ns0:consultaMovimientosCuenta) external;
declare variable $BEGIN_DATE as xs:string external;
declare variable $END_DATE as xs:string external;

xf:consultaMovimientosCuentaNIIn($consultaMovimientosCuenta,
    $BEGIN_DATE,
    $END_DATE)