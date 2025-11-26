(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataGT/conTransaccionesHistoricas/xsd/conTransaccionesHistoricas_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesHistorica";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataGT/xq/conTransaccionesHistorica/";

declare function xf:conTransaccionesHistorica($codigoPais as xs:string,
    $tipoRegistro as xs:string,
    $numeroTarjeta as xs:string,
    $mes as xs:string,
    $anio as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ data($codigoPais) }</ns0:Pais>
            <ns0:NumCuenta>{ data($numeroTarjeta) }</ns0:NumCuenta>
            <ns0:Tipo>{ data($tipoRegistro) }</ns0:Tipo>
            {
            	if($mes != '')then(
            		<ns0:Mes> { data($mes) } </ns0:Mes>
            	)else()
            }
            {
            	if($anio != '')then(
            		<ns0:Anio> { data($anio) } </ns0:Anio>
            	)else()
            }
        </ns0:InputParameters>
};

declare variable $codigoPais as xs:string external;
declare variable $tipoRegistro as xs:string external;
declare variable $numeroTarjeta as xs:string external;
declare variable $mes as xs:string external;
declare variable $anio as xs:string external;

xf:conTransaccionesHistorica($codigoPais,
    $tipoRegistro,
    $numeroTarjeta,
    $mes,
    $anio)