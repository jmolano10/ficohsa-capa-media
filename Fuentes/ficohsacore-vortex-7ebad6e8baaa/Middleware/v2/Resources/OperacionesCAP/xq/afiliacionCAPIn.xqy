xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$afiliacionCAPRequest" element="ns0:afiliacionCAPRequest" location="../xsd/operacionesCAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/AfiliacionCAP/xsd/afiliacionCAP_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/afiliacionCAP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/afiliacionCAPIn/";

declare function xf:afiliacionCAPIn($afiliacionCAPRequest as element(ns0:afiliacionCAPRequest),
    $codigoPais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGO_PAIS>{ $codigoPais }</ns1:PV_CODIGO_PAIS>
            <ns1:PV_ID_CLIENTE>{ data($afiliacionCAPRequest/ID_CLIENTE) }</ns1:PV_ID_CLIENTE>
            <ns1:PV_CUENTA_AP>{ data($afiliacionCAPRequest/CUENTA_AP) }</ns1:PV_CUENTA_AP>
            <ns1:PV_ORIGEN_FONDOS>{ data($afiliacionCAPRequest/ORIGEN_FONDOS) }</ns1:PV_ORIGEN_FONDOS>
            <ns1:PV_CUENTA_DESTINO>{ data($afiliacionCAPRequest/CUENTA_DESTINO) }</ns1:PV_CUENTA_DESTINO>
            <ns1:PV_TIPO_ORIGEN_FONDOS>{ data($afiliacionCAPRequest/TIPO_ORIGEN_FONDOS) }</ns1:PV_TIPO_ORIGEN_FONDOS>
            <ns1:PV_MONEDA>{ data($afiliacionCAPRequest/MONEDA) }</ns1:PV_MONEDA>
            <ns1:PN_MONTO>{ data($afiliacionCAPRequest/MONTO) }</ns1:PN_MONTO>
            <ns1:PD_FECHA_AFILIACION>{ data($afiliacionCAPRequest/FECHA_AFILIACION) }</ns1:PD_FECHA_AFILIACION>
            <ns1:PN_TIEMPO_AFILIACION>{ data($afiliacionCAPRequest/TIEMPO_AFILIACION) }</ns1:PN_TIEMPO_AFILIACION>
            <ns1:PV_FRECUENCIA_DEBITO>{ data($afiliacionCAPRequest/FRECUENCIA_DEBITO) }</ns1:PV_FRECUENCIA_DEBITO>
            <ns1:PN_RENOVACION_AUTOMATICA>{ data($afiliacionCAPRequest/RENOVACION_AUTOMATICA) }</ns1:PN_RENOVACION_AUTOMATICA>
            <ns1:PD_FECHA_PRIMER_CREDITO>{ data($afiliacionCAPRequest/FECHA_PRIMER_CREDITO) }</ns1:PD_FECHA_PRIMER_CREDITO>
            <ns1:PN_NOTIFICACION_CORREO>{ data($afiliacionCAPRequest/NOTIFICACION_CORREO) }</ns1:PN_NOTIFICACION_CORREO>
            <ns1:PV_ESTADO>{ data($afiliacionCAPRequest/ESTADO) }</ns1:PV_ESTADO>
            <ns1:PV_CANAL_CREACION>{ data($afiliacionCAPRequest/CANAL_CREACION) }</ns1:PV_CANAL_CREACION>
            <ns1:PV_OFICIAL_CREACION>{ data($afiliacionCAPRequest/OFICIAL_CREACION) }</ns1:PV_OFICIAL_CREACION>
            <ns1:PV_OFICIAL_AUTORIZADOR>{ data($afiliacionCAPRequest/OFICIAL_AUTORIZADOR) }</ns1:PV_OFICIAL_AUTORIZADOR>
            <ns1:PV_AGENCIA>{ data($afiliacionCAPRequest/AGENCIA) }</ns1:PV_AGENCIA>
            {
                for $NUMERO_TARJETA in $afiliacionCAPRequest/NUMERO_TARJETA
                return
                    <ns1:PV_NUMERO_TARJETA>{ data($NUMERO_TARJETA) }</ns1:PV_NUMERO_TARJETA>
            }
            {
                for $CUENTA_VPLUS in $afiliacionCAPRequest/CUENTA_VPLUS
                return
                    <ns1:PV_CUENTA_VPLUS>{ data($CUENTA_VPLUS) }</ns1:PV_CUENTA_VPLUS>
            }
        </ns1:InputParameters>
};

declare variable $afiliacionCAPRequest as element(ns0:afiliacionCAPRequest) external;
declare variable $codigoPais as xs:string external;

xf:afiliacionCAPIn($afiliacionCAPRequest,
    $codigoPais)