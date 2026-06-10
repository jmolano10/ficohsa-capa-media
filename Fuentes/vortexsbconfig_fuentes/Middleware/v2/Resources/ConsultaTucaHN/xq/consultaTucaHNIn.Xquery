<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0";

(:: pragma bea:global-element-parameter parameter="$rspObtenerParametrizacion"
    element="ns2:OutputParameters"
    location="../../../../Business_Resources/general/Resources/ObtenerParametrizacion/xsd/ORA_BANK_OSB_GET_CONFIG.xsd" ::)

(:: pragma bea:global-element-parameter parameter="$consultaTucaHNRequest"
    element="ns0:consultaTucaHNRequest"
    location="../xsd/consultaTucaHNTypes.xsd" ::)

(:: pragma bea:global-element-return
    element="ns1:Reporte"
    location="../../../BusinessServices/OIC/consultaTuca/wsdl/consultaTucaHN.wsdl" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/";
declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTucaHNTypes";
declare namespace xf  = "http://tempuri.org/Middleware/v2/Resources/OriginacionCreditoGT/xq/consultaTucaIn/";

declare function xf:getUsername($Username as xs:string) as xs:string {
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($Username)))
    return $data/con:username/text()
};

declare function xf:getPassword($Username as xs:string) as xs:string {
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($Username)))
    return $data/con:password/text()
};

declare function xf:buildXmlConsulta(
    $Username as xs:string,
    $consultaTucaHNRequest as element(ns0:consultaTucaHNRequest)
) as element(*)
{
    (: --- Documento recibido --- :)
    let $numeroId :=
        normalize-space(
            (
                data($consultaTucaHNRequest/ns0:RTN),
                data($consultaTucaHNRequest/RTN),
                data($consultaTucaHNRequest/ns0:CEDULA_IDENTIFICACION_PERSONAL),
                data($consultaTucaHNRequest/CEDULA_IDENTIFICACION_PERSONAL)
            )[1]
        )

    (: --- Documento solo con números (quita guiones) --- :)
    let $numeroIdLimpio :=
        translate($numeroId, "- ", "")

    (: --- Determinar si es jurídico --- :)
    let $esJuridico :=
        exists(
            (
                data($consultaTucaHNRequest/ns0:RTN),
                data($consultaTucaHNRequest/RTN)
            )[1]
        )
        or string-length($numeroIdLimpio) > 13

    (: --- Tipo sujeto --- :)
    let $tipoSujeto :=
        if ($esJuridico) then "juridico" else "fisico"

    (: --- Tipo documento --- :)
    let $tipoDocumento :=
        if ($esJuridico)
        then "REGISTRO TRIBUTARIO NACIONAL "
        else "CEDULA DE IDENTIFICACION PERSONAL"

    return
        <tuca>
            <hd>
                <t_doc>11</t_doc>
                <id_user>{ fn-bea:fail-over(xf:getUsername($Username), $Username) }</id_user>
                <pwd>{ fn-bea:fail-over(xf:getPassword($Username), '') }</pwd>
                <id_pais>HN</id_pais>
            </hd>
            <parametros>
                <par tipo="tipo_sujeto">{ $tipoSujeto }</par>
                <par tipo="MOTIVO">1</par>
                <par tipo="{ $tipoDocumento }">{ $numeroId }</par>
                <par tipo="calificacion">133</par>
            </parametros>
        </tuca>
};

declare function xf:consultaTucaHNIn(
    $rspObtenerParametrizacion as element(ns2:OutputParameters),
    $consultaTucaHNRequest as element(ns0:consultaTucaHNRequest)
) as element(ns1:Reporte)
{
    <ns1:Reporte>
        <ns1:xmlConsulta>
            {
                fn-bea:serialize(
                    xf:buildXmlConsulta(
                        data($rspObtenerParametrizacion/ns2:CONFIGURACIONES
                            /ns2:CONFIGURACIONES_ITEM[1]/ns2:VALUE),
                        $consultaTucaHNRequest
                    )
                )
            }
        </ns1:xmlConsulta>
    </ns1:Reporte>
};

declare variable $rspObtenerParametrizacion as element(ns2:OutputParameters) external;
declare variable $consultaTucaHNRequest as element(ns0:consultaTucaHNRequest) external;

xf:consultaTucaHNIn($rspObtenerParametrizacion, $consultaTucaHNRequest)]]></con:xquery>
</con:xqueryEntry>