<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaSeguroClienteTypes";
(:: import schema at "../xsd/consultaSeguroClienteTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/Insurance";
(:: import schema at "../../../BusinessServices/ConsultaSeguroCliente/xsd/ConsultaSegurosTypes.xsd" ::)

declare variable $seguroResponse as element() (:: schema-element(ns1:consultaSegurosResponse) ::) external;

declare function local:func($seguroResponse as element() (:: schema-element(ns1:consultaSegurosResponse) ::)) as element() (:: schema-element(ns2:consultaSeguroClienteResponse) ::) {
    <ns2:consultaSeguroClienteResponse>
        {
            for $certificados in $seguroResponse/body/certificados
            return 
            <certificados>
                <NOMBRE_PRODUCTO_SEGURO>{fn:data($certificados/nombreProductoSeguro)}</NOMBRE_PRODUCTO_SEGURO>
                <NUMERO_CERTIFICADO>{fn:data($certificados/numeroCertificado)}</NUMERO_CERTIFICADO>
                <DESCRIPCION_ESTADO_CERTIFICADO>{fn:data($certificados/descripcionEstadoCertificado)}</DESCRIPCION_ESTADO_CERTIFICADO>
                <FECHA_VENTA_SEGURO>{fn:data($certificados/fechaVentaSeguro)}</FECHA_VENTA_SEGURO>
                <FECHA_VENCIMIENTO_SEGURO>{fn:data($certificados/fechaVencimientoSeguro)}</FECHA_VENCIMIENTO_SEGURO>
                <SUMA_ASEGURADA>{fn:data($certificados/sumaAsegurada)}</SUMA_ASEGURADA>
                <NOMBRE_PLAN_SEGURO>{fn:data($certificados/nombrePlanSeguro)}</NOMBRE_PLAN_SEGURO>
                <PRIMA_CUOTA>{fn:data($certificados/primaCuota)}</PRIMA_CUOTA>
                <MEDIO_PAGO>{fn:data($certificados/medioPago)}</MEDIO_PAGO>
                <FRECUENCIA_PAGO>{fn:data($certificados/frecuenciaPago)}</FRECUENCIA_PAGO>
                <MONEDA_POLIZA>{fn:data($certificados/monedaPoliza)}</MONEDA_POLIZA>
                <CLIENTE>
                    <NOMBRE_COMPLETO>{fn:data($certificados/cliente/nombreCompleto)}</NOMBRE_COMPLETO>
                    <NUMERO_IDENTIFICACION>{fn:data($certificados/cliente/numeroIdentificacion)}</NUMERO_IDENTIFICACION>
                    <FECHA_NACIMIENTO>{fn:data($certificados/cliente/fechaNacimiento)}</FECHA_NACIMIENTO></CLIENTE>
                {
                    for $beneficiarios in $certificados/beneficiarios
                    return 
                    <BENEFICIARIOS>
                        <NOMBRE_COMPLETO>{fn:data($beneficiarios/nombreCompleto)}</NOMBRE_COMPLETO>
                        <PORCENTAJE>{fn:data($beneficiarios/porcentaje)}</PORCENTAJE>
                        <PARENTESCO>{fn:data($beneficiarios/parentesco)}</PARENTESCO></BENEFICIARIOS>
                }
                {
                    for $aseguradosAdicionales in $certificados/aseguradosAdicionales
                    return 
                    <ASEGURADOS_ADICIONALES>
                        <NOMBRE_COMPLETO>{fn:data($aseguradosAdicionales/nombreCompleto)}</NOMBRE_COMPLETO>
                        <NUMERO_IDENTIFICACION>{fn:data($aseguradosAdicionales/numeroIdentificacion)}</NUMERO_IDENTIFICACION>
                        <PARENTESCO>{fn:data($aseguradosAdicionales/parentesco)}</PARENTESCO>
                        <FECHA_NACIMIENTO>{fn:data($aseguradosAdicionales/fechaNacimiento)}</FECHA_NACIMIENTO></ASEGURADOS_ADICIONALES>
                }</certificados>
        }
    </ns2:consultaSeguroClienteResponse>
};

local:func($seguroResponse)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/consultaSeguroClienteTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/ConsultaSeguroCliente/xsd/consultaSeguroClienteTypes"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/ConsultaSeguroCliente/xsd/ConsultaSegurosTypes.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/ConsultaSeguroCliente/xsd/ConsultaSegurosTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>