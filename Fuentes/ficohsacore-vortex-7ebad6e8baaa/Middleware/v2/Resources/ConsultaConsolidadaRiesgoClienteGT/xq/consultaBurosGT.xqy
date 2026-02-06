xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaConsolidadaRiesgoCliente" element="ns0:consultaConsolidadaRiesgoCliente" location="../../ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaBuros" location="../../../BusinessServices/DataWarehouse/consultaBurosPrecreditoGT/wsdl/consultaBurosPrecreditoGT.wsdl" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaConsolidadaRiesgoClienteGT/xq/consultaBurosGT/";

declare function xf:consultaBurosGT($KEY as xs:string,
    $IP as xs:string,
    $PC as xs:string,
    $consultaConsolidadaRiesgoCliente as element(ns0:consultaConsolidadaRiesgoCliente))
    as element(ns1:ConsultaBuros) {
        <ns1:ConsultaBuros>
            <ns1:MSGPRE>
                <ns1:HEADER>
                    <ns1:KEY>{ $KEY }</ns1:KEY>
                    <ns1:CODIGO_EMPRESA>1</ns1:CODIGO_EMPRESA>
                    <ns1:RELACION_PROSPECTO>DE</ns1:RELACION_PROSPECTO>
                    {
                        for $PERSON_TYPE in $consultaConsolidadaRiesgoCliente/PERSON_TYPE
                        return
                            <ns1:TIPO_PERSONA>{ data($PERSON_TYPE) }</ns1:TIPO_PERSONA>
                    }
                    {
                        for $PRODUCT_CODE in $consultaConsolidadaRiesgoCliente/PRODUCT_CODE
                        return
                            <ns1:CODIGO_PRODUCTO>{ data($PRODUCT_CODE) }</ns1:CODIGO_PRODUCTO>
                    }
                    {
                        for $USER_NAME in $consultaConsolidadaRiesgoCliente/USER_NAME
                        return
                            <ns1:USUARIO>{ data($USER_NAME) }</ns1:USUARIO>
                    }
                    <ns1:PC>{ $PC }</ns1:PC>
                    <ns1:IP>{ $IP }</ns1:IP>
                </ns1:HEADER>
                <ns1:BODY>
                    <ns1:NIT>{ data($consultaConsolidadaRiesgoCliente/FISCAL_ID) }</ns1:NIT>
                    <ns1:PRIMER_NOMBRE>{ data($consultaConsolidadaRiesgoCliente/FIRST_NAME) }</ns1:PRIMER_NOMBRE>
                    <ns1:SEGUNDO_NOMBRE/>
                    <ns1:TERCER_NOMBRE/>
                    {
                        let $__nullable := ( data($consultaConsolidadaRiesgoCliente/LAST_NAME) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <ns1:PRIMER_APELLIDO>{ $__nullable }</ns1:PRIMER_APELLIDO>
                            else
                                ()
                    }
                    <ns1:SEGUNDO_APELLIDO/>
                    <ns1:TERCER_APELLIDO/>
                    <ns1:PASAPORTE/>
                    <ns1:PAIS_PASAPORTE/>
                    <ns1:DPI>{ data($consultaConsolidadaRiesgoCliente/CUSTOMER_LEGAL_ID) }</ns1:DPI>
                    <ns1:FECHA_NACIMIENTO>{ data($consultaConsolidadaRiesgoCliente/BIRTH_DATE) }</ns1:FECHA_NACIMIENTO>
                </ns1:BODY>
            </ns1:MSGPRE>
        </ns1:ConsultaBuros>
};

declare variable $KEY as xs:string external;
declare variable $IP as xs:string external;
declare variable $PC as xs:string external;
declare variable $consultaConsolidadaRiesgoCliente as element(ns0:consultaConsolidadaRiesgoCliente) external;

xf:consultaBurosGT($KEY,
    $IP,
    $PC,
    $consultaConsolidadaRiesgoCliente)