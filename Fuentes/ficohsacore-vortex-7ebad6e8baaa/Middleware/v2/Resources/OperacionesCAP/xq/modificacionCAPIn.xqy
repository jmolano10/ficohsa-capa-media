xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$modificacionCAPRequest" element="ns0:modificacionCAPRequest" location="../xsd/operacionesCAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ModificacionCAP/xsd/modificacionCAP_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/modificacionCAP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/modificacionCAPIn/";

declare function xf:modificacionCAPIn($modificacionCAPRequest as element(ns0:modificacionCAPRequest),
    $codigoPais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGO_PAIS>{ $codigoPais }</ns1:PV_CODIGO_PAIS>
            <ns1:PN_ID_CAP>{ data($modificacionCAPRequest/ID_CAP) }</ns1:PN_ID_CAP>
            <ns1:PV_ID_CLIENTE>{ data($modificacionCAPRequest/ID_CLIENTE) }</ns1:PV_ID_CLIENTE>
            <ns1:PV_CUENTA_AP>{ data($modificacionCAPRequest/CUENTA_AP) }</ns1:PV_CUENTA_AP>
            <ns1:PV_ORIGEN_FONDOS>{ data($modificacionCAPRequest/ORIGEN_FONDOS) }</ns1:PV_ORIGEN_FONDOS>
            <ns1:PV_CUENTA_DESTINO>{ data($modificacionCAPRequest/CUENTA_DESTINO) }</ns1:PV_CUENTA_DESTINO>
            <ns1:PV_TIPO_ORIGEN_FONDOS>{ data($modificacionCAPRequest/TIPO_ORIGEN_FONDOS) }</ns1:PV_TIPO_ORIGEN_FONDOS>
            <ns1:PV_MONEDA>{ data($modificacionCAPRequest/MONEDA) }</ns1:PV_MONEDA>
            <ns1:PN_MONTO>{ data($modificacionCAPRequest/MONTO) }</ns1:PN_MONTO>
            <ns1:PD_FECHA_AFILIACION>{ data($modificacionCAPRequest/FECHA_AFILIACION) }</ns1:PD_FECHA_AFILIACION>
            <ns1:PN_TIEMPO_AFILICIACION>{ data($modificacionCAPRequest/TIEMPO_AFILIACION) }</ns1:PN_TIEMPO_AFILICIACION>
            <ns1:PV_FRECUENCIA_DEBITO>{ data($modificacionCAPRequest/FRECUENCIA_DEBITO) }</ns1:PV_FRECUENCIA_DEBITO>
            <ns1:PN_RENOVACION_AUTOMATICA>{ data($modificacionCAPRequest/RENOVACION_AUTOMATICA) }</ns1:PN_RENOVACION_AUTOMATICA>
            <ns1:PD_FECHA_PRIMER_CREDITO>{ data($modificacionCAPRequest/FECHA_PRIMER_CREDITO) }</ns1:PD_FECHA_PRIMER_CREDITO>
            <ns1:PN_NOTIFICACION_CORREO>{ data($modificacionCAPRequest/NOTIFICACION_CORREO) }</ns1:PN_NOTIFICACION_CORREO>
            <ns1:PV_ESTADO>{ data($modificacionCAPRequest/ESTADO) }</ns1:PV_ESTADO>
            <ns1:PV_CANAL_CREACION>{ data($modificacionCAPRequest/CANAL_CREACION) }</ns1:PV_CANAL_CREACION>
            <ns1:PV_OFICIAL_MODIFICACION>{ data($modificacionCAPRequest/OFICIAL_MODIFICACION) }</ns1:PV_OFICIAL_MODIFICACION>
            <ns1:PV_OFICIAL_AUTORIZADOR_MODIFICADOR>{ data($modificacionCAPRequest/OFICIAL_AUTORIZADOR) }</ns1:PV_OFICIAL_AUTORIZADOR_MODIFICADOR>
            <ns1:PV_AGENCIA>{ data($modificacionCAPRequest/AGENCIA) }</ns1:PV_AGENCIA>
            {
                for $NUMERO_TARJETA in $modificacionCAPRequest/NUMERO_TARJETA
                return
                    <ns1:PV_CARD_NUMBER>{ data($NUMERO_TARJETA) }</ns1:PV_CARD_NUMBER>
            }
            {
                for $CUENTA_VPLUS in $modificacionCAPRequest/CUENTA_VPLUS
                return
                    <ns1:PV_CUENTA_VPLUS>{ data($CUENTA_VPLUS) }</ns1:PV_CUENTA_VPLUS>
            }
        </ns1:InputParameters>
};

declare variable $modificacionCAPRequest as element(ns0:modificacionCAPRequest) external;
declare variable $codigoPais as xs:string external;

xf:modificacionCAPIn($modificacionCAPRequest,
    $codigoPais)