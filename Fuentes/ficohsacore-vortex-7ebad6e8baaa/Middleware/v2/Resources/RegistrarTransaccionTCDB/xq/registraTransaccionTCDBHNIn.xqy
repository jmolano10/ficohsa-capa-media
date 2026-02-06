xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$registrarTransaccionTCDB" element="ns1:registrarTransaccionTCDB" location="../xsd/registrarTransaccionTCDBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/PAGOSWSTC/registraPagoTC/xsd/registraPagoTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraPagoTC";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registrarTransaccionTCDBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistrarTransaccionTCDB/xq/registraPagosTCHNIn/";

declare function xf:registraPagosTCHNIn($registrarTransaccionTCDB as element(ns1:registrarTransaccionTCDB),
    $merchantNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_AGENCIAORIGEN>{ data($registrarTransaccionTCDB/AGENCIAORIGEN) }</ns0:PN_AGENCIAORIGEN>
                    <ns0:PV_MERCHANTNUMBER>{ data($merchantNumber) }</ns0:PV_MERCHANTNUMBER>
            {
                for $NUMEROTARJETA in $registrarTransaccionTCDB/NUMEROTARJETA
                return
                    <ns0:PV_NUMEROTARJETA>{ data($NUMEROTARJETA) }</ns0:PV_NUMEROTARJETA>
            }
            {
                for $TIPOOPERACION in $registrarTransaccionTCDB/TIPOOPERACION
                return
                    <ns0:PV_TIPOOPERACION>{ data($TIPOOPERACION) }</ns0:PV_TIPOOPERACION>
            }
            <ns0:PN_TIPOMONEDA>{ data($registrarTransaccionTCDB/TIPOMONEDA) }</ns0:PN_TIPOMONEDA>
            <ns0:PN_ORGANIZACION>{ data($registrarTransaccionTCDB/ORGANIZACION) }</ns0:PN_ORGANIZACION>
            {
                for $MONEDATRANSACCION in $registrarTransaccionTCDB/MONEDATRANSACCION
                return
                    <ns0:PV_MONEDATRANSACCION>{ data($MONEDATRANSACCION) }</ns0:PV_MONEDATRANSACCION>
            }
            <ns0:PN_TASACAMBIO>{ data($registrarTransaccionTCDB/TASACAMBIO) }</ns0:PN_TASACAMBIO>
            <ns0:PN_TIPOTRANSACCION>{ data($registrarTransaccionTCDB/TIPOTRANSACCION) }</ns0:PN_TIPOTRANSACCION>
            {
                for $CODIGOUSUARIO in $registrarTransaccionTCDB/CODIGOUSUARIO
                return
                    <ns0:PV_CODIGOUSUARIO>{ data($CODIGOUSUARIO) }</ns0:PV_CODIGOUSUARIO>
            }
            <ns0:PV_SECUENCIAMOVIMIENTO>{ data($registrarTransaccionTCDB/SECUENCIAMOVIMIENTO) }</ns0:PV_SECUENCIAMOVIMIENTO>
            {
                for $SECUENCIAORIGEN in $registrarTransaccionTCDB/SECUENCIAORIGEN
                return
                    <ns0:PV_SECUENCIAORIGEN>{ data($SECUENCIAORIGEN) }</ns0:PV_SECUENCIAORIGEN>
            }
            <ns0:PN_VALOREFECTIVO>{ data($registrarTransaccionTCDB/VALOREFECTIVO) }</ns0:PN_VALOREFECTIVO>
            <ns0:PN_VALORCHEQUES>{ data($registrarTransaccionTCDB/VALORCHEQUES) }</ns0:PN_VALORCHEQUES>
            <ns0:PN_NUMERODOCUMENTO>{ data($registrarTransaccionTCDB/NUMERODOCUMENTO) }</ns0:PN_NUMERODOCUMENTO>
            <ns0:PD_FECHAVALIDA>{ data($registrarTransaccionTCDB/FECHAVALIDA) }</ns0:PD_FECHAVALIDA>
            <ns0:PN_TIPOCHEQUE>{ data($registrarTransaccionTCDB/TIPOCHEQUE) }</ns0:PN_TIPOCHEQUE>
            {
                for $BANCOORIGEN in $registrarTransaccionTCDB/BANCOORIGEN
                return
                    <ns0:PV_BANCOORIGEN>{ data($BANCOORIGEN) }</ns0:PV_BANCOORIGEN>
            }
            {
                for $BANCODESTINO in $registrarTransaccionTCDB/BANCODESTINO
                return
                    <ns0:PV_BANCODESTINO>{ data($BANCODESTINO) }</ns0:PV_BANCODESTINO>
            }
			<ns0:PV_CANAL>{ data($registrarTransaccionTCDB/CANAL) }</ns0:PV_CANAL>
            <ns0:PV_NUMEROAUTORIZACION>{ data($registrarTransaccionTCDB/NUMEROAUTORIZACION) }</ns0:PV_NUMEROAUTORIZACION>
            {
            	if(data($registrarTransaccionTCDB/APLICADO) != "")then(
            		<ns0:PV_APLICADO>{ data($registrarTransaccionTCDB/APLICADO) }</ns0:PV_APLICADO>
            	)else(
            		<ns0:PV_APLICADO>N</ns0:PV_APLICADO>
            	)
            }
            {
            	if(data($registrarTransaccionTCDB/APLICARENLINEA) != "")then(
            		<ns0:PV_APLICARENLINEA>{ data($registrarTransaccionTCDB/APLICARENLINEA) }</ns0:PV_APLICARENLINEA>
            	)else(
            		<ns0:PV_APLICARENLINEA>S</ns0:PV_APLICARENLINEA>
            	)
            }       
        </ns0:InputParameters>
};

declare variable $registrarTransaccionTCDB as element(ns1:registrarTransaccionTCDB) external;
declare variable $merchantNumber as xs:string external;

xf:registraPagosTCHNIn($registrarTransaccionTCDB,
    $merchantNumber)