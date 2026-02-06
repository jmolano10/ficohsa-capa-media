xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$obtenerEncabezadosV2Response" element="ns0:ObtenerEncabezadosV2Response" location="../../../BusinessServices/VisionPlusREG/obtenerSerializado/xsd/bfemEECCHistorico.xsd" ::)
(:: pragma bea:global-element-return element="ns1:generaEstadoCuentaTCResponse" location="../../GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generaEstadoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraEstadoCuentaTC/xq/testout2/";

declare function xf:ObtenerEncabezadoNIOut($obtenerEncabezadosV2Response as element(ns0:ObtenerEncabezadosV2Response),
    $numerotarjeta as xs:string,
    $tipoarchivo as xs:string)
    as element(ns1:generaEstadoCuentaTCResponse) {
        <ns1:generaEstadoCuentaTCResponse>
            <CARD_NUMBER>{ $numerotarjeta }</CARD_NUMBER>
            {
                for $NumCuenta in $obtenerEncabezadosV2Response/ns0:ObtenerEncabezadosV2Result/ns2:Encabezados/ns2:DatoObtenerEncabezadosV2[1]/ns2:NumCuenta
                return
                    <ACCOUNT_NUMBER>{ data($NumCuenta) }</ACCOUNT_NUMBER>
            }
            {
                for $Periodo in $obtenerEncabezadosV2Response/ns0:ObtenerEncabezadosV2Result/ns2:Encabezados/ns2:DatoObtenerEncabezadosV2[1]/ns2:Periodo
                return
                    <MONTH>{ fn:substring(data($Periodo),5,2) }</MONTH>
            }
            {
                for $Periodo in $obtenerEncabezadosV2Response/ns0:ObtenerEncabezadosV2Result/ns2:Encabezados/ns2:DatoObtenerEncabezadosV2[1]/ns2:Periodo
                return
                    <YEAR>{ fn:substring(data($Periodo),1,4) }</YEAR>
            }
            <FILE_EXTENSION>{ $tipoarchivo }</FILE_EXTENSION>
            {
                for $FileLink in $obtenerEncabezadosV2Response/ns0:ObtenerEncabezadosV2Result/ns2:Encabezados/ns2:DatoObtenerEncabezadosV2[1]/ns2:FileLink
                return
                    <FILE_LINK>{ data($FileLink) }</FILE_LINK>
            }
        </ns1:generaEstadoCuentaTCResponse>
};

declare variable $obtenerEncabezadosV2Response as element(ns0:ObtenerEncabezadosV2Response) external;
declare variable $numerotarjeta as xs:string external;
declare variable $tipoarchivo as xs:string external;

xf:ObtenerEncabezadoNIOut($obtenerEncabezadosV2Response,
    $numerotarjeta,
    $tipoarchivo)