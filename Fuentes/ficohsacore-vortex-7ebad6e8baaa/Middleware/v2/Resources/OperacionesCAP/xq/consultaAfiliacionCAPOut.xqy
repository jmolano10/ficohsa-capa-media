xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ConsultaAfiliacionCAP/xsd/consultaAfiliacionCAP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaAfiliacionCAPResponse" location="../xsd/operacionesCAPTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaAfiliacionCAP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/consultaAfiliacionCAPOut/";

declare function xf:consultaAfiliacionCAPOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaAfiliacionCAPResponse) {
        <ns1:consultaAfiliacionCAPResponse>
            {
                for $PN_ID_CAP in $outputParameters/ns0:PN_ID_CAP
                return
                    <ID_CAP>{ data($PN_ID_CAP) }</ID_CAP>
            }
            {
                for $PV_ID_CLIENTE in $outputParameters/ns0:PV_ID_CLIENTE
                return
                    <ID_CLIENTE>{ data($PV_ID_CLIENTE) }</ID_CLIENTE>
            }
            {
                for $PV_ORIGEN_FONDOS in $outputParameters/ns0:PV_ORIGEN_FONDOS
                return
                    <ORIGEN_FONDOS>{ data($PV_ORIGEN_FONDOS) }</ORIGEN_FONDOS>
            }
            {
                for $PV_CUENTA_DESTINO in $outputParameters/ns0:PV_CUENTA_DESTINO
                return
                    <CUENTA_DESTINO>{ data($PV_CUENTA_DESTINO) }</CUENTA_DESTINO>
            }
            {
                for $PV_TIPO_ORIGEN_FONDOS in $outputParameters/ns0:PV_TIPO_ORIGEN_FONDOS
                return
                    <TIPO_ORIGEN_FONDOS>{ data($PV_TIPO_ORIGEN_FONDOS) }</TIPO_ORIGEN_FONDOS>
            }
            {
                for $PV_MONEDA in $outputParameters/ns0:PV_MONEDA
                return
                    <MONEDA>{ data($PV_MONEDA) }</MONEDA>
            }
            {
                for $PN_MONTO in $outputParameters/ns0:PN_MONTO
                return
                    <MONTO>{ data($PN_MONTO) }</MONTO>
            }
            {
                for $PD_FECHA_AFILIACION in $outputParameters/ns0:PD_FECHA_AFILIACION
                return
                    <FECHA_AFILIACION>{ data($PD_FECHA_AFILIACION) }</FECHA_AFILIACION>
            }
            {
                for $PN_TIEMPO_AFILIACION in $outputParameters/ns0:PN_TIEMPO_AFILIACION
                return
                    <TIEMPO_AFILIACION>{ data($PN_TIEMPO_AFILIACION) }</TIEMPO_AFILIACION>
            }
            {
                for $PV_FRECUENCIA_DEBITO in $outputParameters/ns0:PV_FRECUENCIA_DEBITO
                return
                    <FRECUENCIA_DEBITO>{ data($PV_FRECUENCIA_DEBITO) }</FRECUENCIA_DEBITO>
            }
            {
                for $PN_RENOVACION_AUTOMATICA in $outputParameters/ns0:PN_RENOVACION_AUTOMATICA
                return
                    <RENOVACION_AUTOMATICA>{ data($PN_RENOVACION_AUTOMATICA) }</RENOVACION_AUTOMATICA>
            }
            {
                for $PD_FECHA_PRIMER_CREDITO in $outputParameters/ns0:PD_FECHA_PRIMER_CREDITO
                return
                    <FECHA_PRIMER_CREDITO>{ data($PD_FECHA_PRIMER_CREDITO) }</FECHA_PRIMER_CREDITO>
            }
            {
                for $PN_NOTIFICACION_CORREO in $outputParameters/ns0:PN_NOTIFICACION_CORREO
                return
                    <NOTIFICACION_CORREO>{ data($PN_NOTIFICACION_CORREO) }</NOTIFICACION_CORREO>
            }
            {
                for $PV_ESTADO in $outputParameters/ns0:PV_ESTADO
                return
                    <ESTADO>{ data($PV_ESTADO) }</ESTADO>
            }
            {
                for $PV_CANAL_CREACION in $outputParameters/ns0:PV_CANAL_CREACION
                return
                    <CANAL_CREACION>{ data($PV_CANAL_CREACION) }</CANAL_CREACION>
            }
            {
                for $PV_OFICIAL_CREACION in $outputParameters/ns0:PV_OFICIAL_CREACION
                return
                    <OFICIAL_CREACION>{ data($PV_OFICIAL_CREACION) }</OFICIAL_CREACION>
            }
            {
                for $PV_OFICIAL_AUTORIZADOR in $outputParameters/ns0:PV_OFICIAL_AUTORIZADOR
                return
                    <OFICIAL_AUTORIZADOR>{ data($PV_OFICIAL_AUTORIZADOR) }</OFICIAL_AUTORIZADOR>
            }
            {
                for $PV_OFICIAL_MODIFICACION in $outputParameters/ns0:PV_OFICIAL_MODIFICACION
                return
                    <OFICIAL_MODIFICACION>{ data($PV_OFICIAL_MODIFICACION) }</OFICIAL_MODIFICACION>
            }
            {
                for $PV_OFICIAL_AUTORIZADOR_MODIFICADOR in $outputParameters/ns0:PV_OFICIAL_AUTORIZADOR_MODIFICADOR
                return
                    <OFICIAL_AUTORIZADOR_MODIFICADOR>{ data($PV_OFICIAL_AUTORIZADOR_MODIFICADOR) }</OFICIAL_AUTORIZADOR_MODIFICADOR>
            }
            {
                for $PV_AGENCIA in $outputParameters/ns0:PV_AGENCIA
                return
                    <AGENCIA>{ data($PV_AGENCIA) }</AGENCIA>
            }
            {
                for $PD_FECHA_CAMBIO in $outputParameters/ns0:PD_FECHA_CAMBIO
                return
                    <FECHA_CAMBIO>{ data($PD_FECHA_CAMBIO) }</FECHA_CAMBIO>
            }
            {
                for $PN_TRX_PENDIENTES in $outputParameters/ns0:PN_TRX_PENDIENTES
                return
                    <TRANSACCIONES_PENDIENTES>{ data($PN_TRX_PENDIENTES) }</TRANSACCIONES_PENDIENTES>
            }
            {
                for $PN_TRX_FALLIDOS in $outputParameters/ns0:PN_TRX_FALLIDOS
                return
                    <TRANSACCIONES_FALLIDAS>{ data($PN_TRX_FALLIDOS) }</TRANSACCIONES_FALLIDAS>
            }
            {
                for $PN_TRX_EXITOSOS in $outputParameters/ns0:PN_TRX_EXITOSOS
                return
                    <TRANSACCIONES_EXITOSAS>{ data($PN_TRX_EXITOSOS) }</TRANSACCIONES_EXITOSAS>
            }
        </ns1:consultaAfiliacionCAPResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaAfiliacionCAPOut($outputParameters)