<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPrestamoTypeResponse1" element="ns0:ConsultaPrestamoTypeResponse" location="consultaPrestamos/ConsultaPrestamosCliente.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaTarjetaCreditoTypeResponse1" element="ns1:ConsultaTarjetaCreditoTypeResponse" location="consultaTC/ConsultaTarjetaCreditoCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "ConsultaTarjetaCreditoCliente";
declare namespace ns0 = "ConsultaPrestamosCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaPasivosClienteHeaderOut2/";

declare function xf:consultaPasivosClienteHeaderOut2($consultaPrestamoTypeResponse1 as element(ns0:ConsultaPrestamoTypeResponse),
    $consultaTarjetaCreditoTypeResponse1 as element(ns1:ConsultaTarjetaCreditoTypeResponse))
    as element(ns2:ResponseHeader) {
        <ns2:ResponseHeader>
            {
                let $successIndicatorPrestamo := $consultaPrestamoTypeResponse1/ns0:OVERALL_SUCCESS_INDICATOR,
                    $successIndicatorTC := $consultaTarjetaCreditoTypeResponse1/ns1:OVERALL_SUCCESS_INDICATOR
                return
                	if ( data($successIndicatorPrestamo) = "NO RECORDS" and data($successIndicatorTC) = "NO RECORDS") then (
                    	<successIndicator>NO RECORDS</successIndicator>
                    ) else if ( data($successIndicatorPrestamo) != "SUCCESS" and data($successIndicatorTC) != "SUCCESS") then (
                    	<successIndicator>ERROR</successIndicator>
                    ) else (
                    	<successIndicator>Success</successIndicator>
                    )
            }
        </ns2:ResponseHeader>
};

declare variable $consultaPrestamoTypeResponse1 as element(ns0:ConsultaPrestamoTypeResponse) external;
declare variable $consultaTarjetaCreditoTypeResponse1 as element(ns1:ConsultaTarjetaCreditoTypeResponse) external;

xf:consultaPasivosClienteHeaderOut2($consultaPrestamoTypeResponse1,
    $consultaTarjetaCreditoTypeResponse1)]]></con:xquery>
    <con:dependency location="consultaPrestamos/ConsultaPrestamosCliente.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaPrestamos/ConsultaPrestamosCliente"/>
    </con:dependency>
    <con:dependency location="consultaTC/ConsultaTarjetaCreditoCliente.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaTC/ConsultaTarjetaCreditoCliente"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>