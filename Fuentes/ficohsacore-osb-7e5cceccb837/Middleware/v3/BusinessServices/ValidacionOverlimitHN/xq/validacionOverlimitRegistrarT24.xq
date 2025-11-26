(:: pragma bea:global-element-parameter parameter="$registrarTransaccionTCDB" element="ns1:registrarTransaccionTCDB" location="../../../../v2/Resources/RegistrarTransaccionTCDB/xsd/registrarTransaccionTCDBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../xsd/validacionOverlimit_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registrarTransaccionTCDBTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validacionOverlimit";
declare namespace xf = "http://tempuri.org/Middleware/v3/BusinessServices/ValidacionOverlimitHN/xq/validacionOverlimitRegistrarT24/";

declare function xf:validacionOverlimitRegistrarT24($registrarTransaccionTCDB as element(ns1:registrarTransaccionTCDB), $Saldo as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
                    <ns0:PN_MONTOPAGO>{ $Saldo }</ns0:PN_MONTOPAGO>
                    <ns0:PN_SALDOACTUAL>{ 0 }</ns0:PN_SALDOACTUAL>
                    <ns0:PV_MONEDASALDO>{ data($registrarTransaccionTCDB/MONEDATRANSACCION) }</ns0:PV_MONEDASALDO>
                    <ns0:PN_MEMO_DB>{ 0 }</ns0:PN_MEMO_DB>
                    <ns0:PN_MEMO_CR>{ 0 }</ns0:PN_MEMO_CR>
                    <ns0:PV_PAIS>{ data($registrarTransaccionTCDB/BANCOORIGEN) }</ns0:PV_PAIS>
                    <ns0:PV_CRUCE_MONEDA>{ 'RT24' }</ns0:PV_CRUCE_MONEDA>
                    <ns0:PN_TASA_CAMBIO>{ data($registrarTransaccionTCDB/TASACAMBIO) }</ns0:PN_TASA_CAMBIO>
                    {
                    let $messageListFM := fn:tokenize(data($registrarTransaccionTCDB/INFOCLIENTE),"LT")
	                   return(
	                   <PV_IDENTIDAD>{ $messageListFM[1] }</PV_IDENTIDAD>,
		               <PN_CODIGO_CLIENTE>{ $messageListFM[2] }</PN_CODIGO_CLIENTE>
	                   )
	                 }
        </ns0:InputParameters>
};

declare variable $registrarTransaccionTCDB as element(ns1:registrarTransaccionTCDB) external;
declare variable $Saldo as xs:string external;

xf:validacionOverlimitRegistrarT24($registrarTransaccionTCDB, $Saldo)
