xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:afiliacionCAPRequest" location="../../OperacionesCAP/xsd/operacionesCAPTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AfiliacionCAPFacade/xq/afiliacionCAPFacadeIn/";

declare function xf:afiliacionCAPFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:afiliacionCAPRequest) {
    <ns1:afiliacionCAPRequest>
    {
        let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        return (
        
                <ID_CLIENTE>{ $messageListFM[1] }</ID_CLIENTE>,
                <CUENTA_AP>{ $messageListFM[2] }</CUENTA_AP>,
                <ORIGEN_FONDOS>{ $messageListFM[3] }</ORIGEN_FONDOS>,
                <CUENTA_DESTINO>{ $messageListFM[4] }</CUENTA_DESTINO>,
                <TIPO_ORIGEN_FONDOS>{ $messageListFM[5] }</TIPO_ORIGEN_FONDOS>,
                <NUMERO_TARJETA>{ $messageListFM[6] }</NUMERO_TARJETA>,
                <CUENTA_VPLUS>{ $messageListFM[7] }</CUENTA_VPLUS>,
                <MONEDA>{ $messageListFM[8] }</MONEDA>,
                <MONTO>{ $messageListFM[9] }</MONTO>,
                <FECHA_AFILIACION>{ fn-bea:dateTime-from-string-with-format('yyyyMMdd', $messageListFM[10])}</FECHA_AFILIACION>,
                <TIEMPO_AFILIACION>{ $messageListFM[11] }</TIEMPO_AFILIACION>,
                <FRECUENCIA_DEBITO>{ $messageListFM[12] }</FRECUENCIA_DEBITO>,
                <RENOVACION_AUTOMATICA>{ 				 
                if (fn:upper-case($messageListFM[13]) = 'SI') then
                        1
                    else if (fn:upper-case($messageListFM[13]) = 'NO') then
                        0
                    else
                        $messageListFM[13] 
                }</RENOVACION_AUTOMATICA>,
                <FECHA_PRIMER_CREDITO>{ fn-bea:dateTime-from-string-with-format('yyyyMMdd', $messageListFM[14]) }</FECHA_PRIMER_CREDITO>,
                <NOTIFICACION_CORREO>{ 
				 if (fn:upper-case($messageListFM[15]) = 'SI') then
                        1
                    else if (fn:upper-case($messageListFM[15]) = 'NO') then
                        0
                    else
                        $messageListFM[15]
				 }</NOTIFICACION_CORREO>,
                <ESTADO>{ $messageListFM[16] }</ESTADO>,
                <CANAL_CREACION>{ $messageListFM[17] }</CANAL_CREACION>,
                <OFICIAL_CREACION>{ $messageListFM[18] }</OFICIAL_CREACION>,
                <OFICIAL_AUTORIZADOR>{ $messageListFM[19] }</OFICIAL_AUTORIZADOR>,
                <AGENCIA>{ $messageListFM[20] }</AGENCIA>
         
            	) 
	}
	</ns1:afiliacionCAPRequest>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:afiliacionCAPFacadeIn($procesaMensajeGenericoT24)