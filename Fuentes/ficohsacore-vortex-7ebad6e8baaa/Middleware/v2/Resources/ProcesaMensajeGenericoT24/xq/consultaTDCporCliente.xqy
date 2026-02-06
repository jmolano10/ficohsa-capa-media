xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InformacionTarjeta" location="../../../../Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaTDCporCliente2/";
declare namespace ns2 = "http://tempuri.org/";

declare function xf:consultaTDCporCliente2($noTarjetaCredito1 as xs:string)
    as element(ns2:InformacionTarjeta) {
         <ns2:InformacionTarjeta>
          {
        	let $messageList := fn:tokenize($noTarjetaCredito1,"@FM")
        	return(
         <ns2:noTarjetaCredito>{data($messageList[1])}</ns2:noTarjetaCredito>
            )
          }
        </ns2:InformacionTarjeta>
};

declare variable $noTarjetaCredito1 as xs:string external;

xf:consultaTDCporCliente2($noTarjetaCredito1)