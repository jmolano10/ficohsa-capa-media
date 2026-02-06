xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opBuscarSaldoReservadoRespuesta1" element="ns1:opBuscarSaldoReservadoRespuesta" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaDetalleSaldosPignoradosResponse" location="../../../../Business_Resources/ConsultasCuenta/ConsultaDetalleSaldoPignorado/consultaDetalleSaldosPignoradosTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleSaldosPignoradosTypes";
declare namespace ns1 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleSaldosPignorados/xq/consultaDetSaldosPignoradosNI/";

declare function xf:consultaDetSaldosPignoradosNI($opBuscarSaldoReservadoRespuesta1 as element(ns1:opBuscarSaldoReservadoRespuesta))
    as element(ns2:consultaDetalleSaldosPignoradosResponse) {
        <ns2:consultaDetalleSaldosPignoradosResponse>
            <ACCOUNT_NAME>{fn:replace(data($opBuscarSaldoReservadoRespuesta1/ns0:cuenta/ns0:valCuentaHabiente),"[Ññ]", "#")}</ACCOUNT_NAME>           
            <TOTAL_LOCKED_AMOUNT>{ fn:round-half-to-even(data($opBuscarSaldoReservadoRespuesta1/ns0:cuenta/ns0:valMontoBloqueado),2) }</TOTAL_LOCKED_AMOUNT>
            <ns2:consultaDetalleSaldosPignoradosResponseType>
                {
                	let $fechaInicio := $opBuscarSaldoReservadoRespuesta1/ns0:cuentaReserva/ns0:fechaInicio
                	let $fechaLiberacion := $opBuscarSaldoReservadoRespuesta1/ns0:cuentaReserva/ns0:fechaLiberacion
                	let $descripcion := $opBuscarSaldoReservadoRespuesta1/ns0:cuentaReserva/ns0:descripcionReserva
                	let $monto := $opBuscarSaldoReservadoRespuesta1/ns0:cuentaReserva/ns0:montoReserva
                    for $i in 1 to count($fechaInicio)
                    return
                        <ns2:consultaDetalleSaldosPignoradosResponseRecordType>
                            <START_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($fechaInicio[$i])) }</START_DATE>
                            <LIFTING_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($fechaLiberacion[$i])) }</LIFTING_DATE>
                            <DESCRIPTION>{ data($descripcion[$i])}</DESCRIPTION>
                            <AMOUNT>{ fn:round-half-to-even(data($monto[$i]), 2) }</AMOUNT>
                        </ns2:consultaDetalleSaldosPignoradosResponseRecordType>
                }
            </ns2:consultaDetalleSaldosPignoradosResponseType>
           
        </ns2:consultaDetalleSaldosPignoradosResponse>
};

declare variable $opBuscarSaldoReservadoRespuesta1 as element(ns1:opBuscarSaldoReservadoRespuesta) external;

xf:consultaDetSaldosPignoradosNI($opBuscarSaldoReservadoRespuesta1)