xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/registrarBitacoraMensajeISO8583/xsd/registrarBitacoraMensajeISO8583_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarBitacoraMensajeISO8583";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoSwitch/xq/registrarBitacoraMensajeISO8583In/";

declare function xf:registrarBitacoraMensajeISO8583In($ID as xs:string,
    $ID_PETICION as xs:string?,
    $TIPO_REGISTRO as xs:string,
    $MTI as xs:string,
    $CODIGOPR as xs:string,
    $CODIGOINSTADQUIR as xs:string,
    $CODIGOINSTEMISOR as xs:string?,
    $IDTERMINAL as xs:string,
    $MENSAJE as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ID>{ $ID }</ns0:PV_ID>
            <ns0:PV_ID_PETICION>{ $ID_PETICION }</ns0:PV_ID_PETICION>
            <ns0:PV_TIPO_REGISTRO>{ $TIPO_REGISTRO }</ns0:PV_TIPO_REGISTRO>
            <ns0:PV_MTI>{ $MTI }</ns0:PV_MTI>
            <ns0:PV_CODIGOPR>{ $CODIGOPR }</ns0:PV_CODIGOPR>
            <ns0:PV_CODIGOINSTADQUIR>{ $CODIGOINSTADQUIR }</ns0:PV_CODIGOINSTADQUIR>
            <ns0:PV_CODIGOINSTEMISOR>{ $CODIGOINSTEMISOR }</ns0:PV_CODIGOINSTEMISOR>
            <ns0:PV_IDTERMINAL>{ $IDTERMINAL }</ns0:PV_IDTERMINAL>
            <ns0:PV_MENSAJE>{ $MENSAJE }</ns0:PV_MENSAJE>
        </ns0:InputParameters>
};

declare variable $ID as xs:string external;
declare variable $ID_PETICION as xs:string? external;
declare variable $TIPO_REGISTRO as xs:string external;
declare variable $MTI as xs:string external;
declare variable $CODIGOPR as xs:string external;
declare variable $CODIGOINSTADQUIR as xs:string external;
declare variable $CODIGOINSTEMISOR as xs:string external;
declare variable $IDTERMINAL as xs:string external;
declare variable $MENSAJE as xs:string external;

xf:registrarBitacoraMensajeISO8583In($ID,
    $ID_PETICION,
    $TIPO_REGISTRO,
    $MTI,
    $CODIGOPR,
    $CODIGOINSTADQUIR,
    $CODIGOINSTEMISOR,
    $IDTERMINAL,
    $MENSAJE)