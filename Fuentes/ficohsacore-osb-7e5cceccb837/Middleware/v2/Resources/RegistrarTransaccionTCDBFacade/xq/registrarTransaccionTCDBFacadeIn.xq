(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registrarTransaccionTCDB" location="../../RegistrarTransaccionTCDB/xsd/registrarTransaccionTCDBTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registrarTransaccionTCDBTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistrarTransaccionTCDBFacade/xq/registrarTransaccionTCDBIn/";

declare function xf:registrarTransaccionTCDBIn($CODIGOUSUARIO as xs:string, $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:registrarTransaccionTCDB) {
    let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
    return
    	<ns1:registrarTransaccionTCDB>        
           <AGENCIAORIGEN>{ $messageListFM[1] }</AGENCIAORIGEN>
           <MERCHANTNUMBER>{ $messageListFM[2] }</MERCHANTNUMBER>
           <NUMEROTARJETA>{ $messageListFM[3] }</NUMEROTARJETA>
           <TIPOOPERACION>{ $messageListFM[4] }</TIPOOPERACION>
           <TIPOMONEDA>{ $messageListFM[5] }</TIPOMONEDA>
           <ORGANIZACION>{ $messageListFM[6] }</ORGANIZACION>
           <MONEDATRANSACCION>{ $messageListFM[7] }</MONEDATRANSACCION>
           <TASACAMBIO>{ $messageListFM[8] }</TASACAMBIO>
           <TIPOTRANSACCION>{ $messageListFM[9] }</TIPOTRANSACCION>
           <CODIGOUSUARIO>{ $CODIGOUSUARIO }</CODIGOUSUARIO>
           <SECUENCIAMOVIMIENTO>{ $messageListFM[10] }</SECUENCIAMOVIMIENTO>
           <SECUENCIAORIGEN>{ $messageListFM[11] }</SECUENCIAORIGEN>
           <VALOREFECTIVO>{ $messageListFM[12] }</VALOREFECTIVO>
           <VALORCHEQUES>{ $messageListFM[13] }</VALORCHEQUES>
           <NUMERODOCUMENTO>{ $messageListFM[14] }</NUMERODOCUMENTO>
           <FECHAVALIDA>{ $messageListFM[15] }</FECHAVALIDA>
           <TIPOCHEQUE>{ $messageListFM[16] }</TIPOCHEQUE>
           <BANCOORIGEN>{ $messageListFM[17] }</BANCOORIGEN>
           <BANCODESTINO>{ $messageListFM[18] }</BANCODESTINO>
           <DESCRIPCIONTRANSACCION>{ $messageListFM[19] }</DESCRIPCIONTRANSACCION>
           <CANAL>{ $messageListFM[20] }</CANAL>
           <NUMEROAUTORIZACION>{ $messageListFM[21] }</NUMEROAUTORIZACION>
           <APLICADO>{ $messageListFM[22] }</APLICADO>
           <APLICARENLINEA>{ $messageListFM[23] }</APLICARENLINEA>
           <INFOCLIENTE>{ $messageListFM[24] }</INFOCLIENTE>
           <CALCULAROVERLIMIT>{ $messageListFM[25] }</CALCULAROVERLIMIT>
    	</ns1:registrarTransaccionTCDB>
};

declare variable $CODIGOUSUARIO as xs:string external;
declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;
xf:registrarTransaccionTCDBIn($CODIGOUSUARIO, $procesaMensajeGenericoT24)