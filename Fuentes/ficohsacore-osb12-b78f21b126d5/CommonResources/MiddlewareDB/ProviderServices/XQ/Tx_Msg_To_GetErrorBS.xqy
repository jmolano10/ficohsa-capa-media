xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetErrorMessages_BS";
(:: import schema at "../XSD/GetErrorMessages_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $codigoServicio as xs:integer external;
declare variable $codigoSistema as xs:integer external;
declare variable $codigoErrorSistema as xs:string external;
declare variable $descripcionError as xs:string external;
declare variable $codigoLenguaje as xs:string external;

declare function xq:Tx_Msg_To_GetErrorBS($codigoServicio as xs:integer, 
                                         $codigoSistema as xs:integer, 
                                         $codigoErrorSistema as xs:string, 
                                         $descripcionError as xs:string, 
                                         $codigoLenguaje as xs:string) 
                                         as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PN_CODIGO_SERVICIO>{fn:data($codigoServicio)}</ns1:PN_CODIGO_SERVICIO>
        <ns1:PN_CODIGO_SISTEMA>{fn:data($codigoSistema)}</ns1:PN_CODIGO_SISTEMA>
        <ns1:PV_CODIGO_ERROR_SISTEMA>{fn:data($codigoErrorSistema)}</ns1:PV_CODIGO_ERROR_SISTEMA>
        <ns1:PV_DESCRIPCION_ERROR>{fn:data($descripcionError)}</ns1:PV_DESCRIPCION_ERROR>
        <ns1:PV_CODIGO_LENGUAJE>{fn:data($codigoLenguaje)}</ns1:PV_CODIGO_LENGUAJE>
    </ns1:InputParameters>
};

xq:Tx_Msg_To_GetErrorBS($codigoServicio, $codigoSistema, $codigoErrorSistema, $descripcionError, $codigoLenguaje)