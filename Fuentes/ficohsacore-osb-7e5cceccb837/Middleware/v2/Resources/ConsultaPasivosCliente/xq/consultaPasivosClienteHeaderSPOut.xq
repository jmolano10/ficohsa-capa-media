(:: pragma bea:global-element-parameter parameter="$consultaPrestamoTypeResponse" element="ns1:ConsultaPrestamoTypeResponse" location="../../../../Business_Resources/consultasCliente/consultaPasivosCliente/consultaPrestamos/ConsultaPrestamosCliente.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataHN/conDatosTarjetaCliente/xsd/conDatoTarjetaClienteHN_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "ConsultaPrestamosCliente";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetaClienteHN";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClienteHeaderSPOut/";

declare function xf:consultaPasivosClienteHeaderSPOut($consultaPrestamoTypeResponse as element(ns1:ConsultaPrestamoTypeResponse),
    $outputParameters as element(ns0:OutputParameters))
    as element(ns2:ResponseHeader) {
        <ns2:ResponseHeader>
         {
                let $successIndicatorPrestamo := $consultaPrestamoTypeResponse/ns1:OVERALL_SUCCESS_INDICATOR,
                    $successIndicatorTC := $outputParameters/ns0:CodigoError/text()
                return
                	if ( data($successIndicatorPrestamo) = "NO RECORDS" and data($successIndicatorTC)  = "-2") then (
                    	<successIndicator>NO RECORDS</successIndicator>
                    ) else if ( data($successIndicatorPrestamo) != "SUCCESS" and data($successIndicatorTC) != "-1") then (
                    	<successIndicator>ERROR</successIndicator>
                    ) else (
                    	<successIndicator>Success</successIndicator>
                    )
            }
        </ns2:ResponseHeader>
};

declare variable $consultaPrestamoTypeResponse as element(ns1:ConsultaPrestamoTypeResponse) external;
declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaPasivosClienteHeaderSPOut($consultaPrestamoTypeResponse,
    $outputParameters)