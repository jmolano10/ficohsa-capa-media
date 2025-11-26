(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../xsd/pagoRecaudoEEHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:DatosHNPago" location="../../../BusinessServices/RecaudoEEHws/wsdl/recaudoEEHSOAP.wsdl" ::)

declare namespace ns0 = "http://schemas.servicestack.net/types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoEEH/xq/datosHNPagoEEHIn/";
declare namespace soapenv = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace con = "http://schemas.enee-pay.hn/contract";

declare function xf:datosHNPagoEEHIn(
  $pagoRecaudo as element(ns1:pagoRecaudo),
  $agency as xs:string,
  $bank as xs:string,
  $branchoffice as xs:string,
  $user as xs:string,
  $terminal as xs:string,
  $uuiddb as xs:string
	) as element(*) {
		 <con:PagarSaldoRequest xmlns:con="http://schemas.enee-pay.hn/contract">
	      <con:AgenteRecaudador>
	        <con:CodigoAgenteRecaudador>073</con:CodigoAgenteRecaudador>
	        <con:CodigoSucursal>{$branchoffice}</con:CodigoSucursal>
	        <con:Terminal>{$terminal}</con:Terminal>
	        <con:Usuario>{$user}</con:Usuario>
	      </con:AgenteRecaudador>
	      <con:ClavePrimaria>{ data($pagoRecaudo/DEBTOR_CODE)}</con:ClavePrimaria>
	      <con:FechaPago>{ fn-bea:dateTime-to-string-with-format("ddMMYYYY", current-dateTime()) }</con:FechaPago> 
	      <con:HoraPago>{ fn-bea:dateTime-to-string-with-format("HHmmss", fn:adjust-dateTime-to-timezone(current-dateTime(),())) }</con:HoraPago> 
	      <con:IdTransaccionAgenteRecaudador>{ $uuiddb }</con:IdTransaccionAgenteRecaudador> 
	      <con:Monto>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</con:Monto>
	    </con:PagarSaldoRequest>
	};

declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $agency as xs:string external;
declare variable $bank as xs:string external;
declare variable $branchoffice as xs:string external;
declare variable $user as xs:string external;
declare variable $terminal as xs:string external;
declare variable $uuiddb as xs:string external;

xf:datosHNPagoEEHIn($pagoRecaudo, $agency, $bank, $branchoffice, $user, $terminal, $uuiddb)