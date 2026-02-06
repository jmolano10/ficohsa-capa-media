xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:modificacionCAPRequest" location="../../OperacionesCAP/xsd/operacionesCAPTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificacionCAPFacade/xq/modificacionCAPFacadeIn/";

declare function xf:modificacionCAPFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:modificacionCAPRequest) {
    <ns1:modificacionCAPRequest>
    {
    	let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        return (
        
            <ID_CAP>{ $messageListFM[1] }</ID_CAP>,
            <ID_CLIENTE>{ $messageListFM[2] }</ID_CLIENTE>,
            <CUENTA_AP>{ $messageListFM[3] }</CUENTA_AP>,
            <ORIGEN_FONDOS>{ $messageListFM[4] }</ORIGEN_FONDOS>,
            <CUENTA_DESTINO>{ $messageListFM[5] }</CUENTA_DESTINO>,
            <TIPO_ORIGEN_FONDOS>{ $messageListFM[6] }</TIPO_ORIGEN_FONDOS>,
            <NUMERO_TARJETA>{ $messageListFM[7] }</NUMERO_TARJETA>,
            <CUENTA_VPLUS>{ $messageListFM[8] }</CUENTA_VPLUS>,
            <MONEDA>{ $messageListFM[9] }</MONEDA>,
            <MONTO>{ $messageListFM[10] }</MONTO>,
            <FECHA_AFILIACION>{ fn-bea:dateTime-from-string-with-format('yyyyMMdd', $messageListFM[11])}</FECHA_AFILIACION>,
            <TIEMPO_AFILIACION>{ $messageListFM[12] }</TIEMPO_AFILIACION>,
            <FRECUENCIA_DEBITO>{ $messageListFM[13] }</FRECUENCIA_DEBITO>,
            <RENOVACION_AUTOMATICA>{ 				 
                if (fn:upper-case($messageListFM[14]) = 'SI') then
                        1
                    else if (fn:upper-case($messageListFM[14]) = 'NO') then
                        0
                    else
                        $messageListFM[14] 
                }</RENOVACION_AUTOMATICA>,
            <FECHA_PRIMER_CREDITO>{ fn-bea:dateTime-from-string-with-format('yyyyMMdd', $messageListFM[15]) }</FECHA_PRIMER_CREDITO>,
            <NOTIFICACION_CORREO>{ 
				 if (fn:upper-case($messageListFM[16]) = 'SI') then
                        1
                    else if (fn:upper-case($messageListFM[16]) = 'NO') then
                        0
                    else
                        $messageListFM[16]
				 }</NOTIFICACION_CORREO>,
            <ESTADO>{ $messageListFM[17] }</ESTADO>,
            <CANAL_CREACION>{ $messageListFM[18] }</CANAL_CREACION>,
            <OFICIAL_MODIFICACION>{ $messageListFM[19] }</OFICIAL_MODIFICACION>,
            <OFICIAL_AUTORIZADOR>{ $messageListFM[20] }</OFICIAL_AUTORIZADOR>,
            <AGENCIA>{ $messageListFM[21] }</AGENCIA>
        
        )
	}
	</ns1:modificacionCAPRequest>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:modificacionCAPFacadeIn($procesaMensajeGenericoT24)